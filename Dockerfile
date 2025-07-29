# frontend/Dockerfile

# Stage 1: Build the Flutter web app
FROM cirrusci/flutter:latest AS build

WORKDIR /app

# Copy pubspec first to leverage Docker layer caching for dependencies
COPY pubspec.* /app/
RUN flutter pub get

# Copy the rest of your app code
COPY . /app/

# Define ARG instructions to receive values from docker-compose build args
ARG API_URL_ARG
ARG DB_URL_ARG
ARG CLIENT_ID_ARG

# Build the Flutter web app, passing the ARGs to --dart-define
# Ensure these match the String.fromEnvironment names in your Dart code
RUN flutter build web --release \
    --web-renderer html \
    --dart-define=API_URL=${API_URL_ARG} \
    --dart-define=DB_URL=${DB_URL_ARG} \
    --dart-define=ClientId=${CLIENT_ID_ARG}

# Stage 2: Serve the static files with Nginx
FROM nginx:alpine

# Copy the built Flutter web app from the build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose the default Nginx HTTP port (internal to Docker network)
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
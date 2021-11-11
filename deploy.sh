# Build and deploy predictor API
docker build -f Dockerfile_api -t nace-predictor:latest .
docker run -d -p 5000:5000 nace-predictor:latest

# Check that the API service runs
curl localhost:5000/_ah/warmup

# Build and deploy web API
docker build -f Dockerfile_client -t nace-client:latest .
docker run -d -p 3000:3000 nace-client:latest

# Go to website
http://localhost:3000
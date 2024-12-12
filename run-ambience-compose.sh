version=2025.0
docker pull elixirtech/elixir-ambience:${version}
#variables are in .env file
docker compose down 
docker compose up -d 
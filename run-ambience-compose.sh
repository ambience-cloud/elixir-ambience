version=2025.1
export version
docker pull elixirtech/elixir-ambience:${version}
#variables are in .env file
docker compose down 
docker compose up -d 

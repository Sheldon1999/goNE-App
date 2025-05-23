postgres:
	docker run --name postgres-goBank -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secert -d postgres:12-alpine

createdb:
	docker exec -it postgres-goBank createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres-goBank dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secert@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secert@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc


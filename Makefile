build: Dockerfile
	docker build --file Dockerfile --tag uclink:dev .

run: build
	docker run -p 5000:5000 uclink:dev  

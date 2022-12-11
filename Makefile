install:
	pip3 install -r requirements.txt
dev-run:
	UPTRACE_DSN=http://project2_secret_token@127.0.0.1:14318/2 uvicorn main:app --host 0.0.0.0 --reload
run:
	uvicorn main:app --host 0.0.0.0
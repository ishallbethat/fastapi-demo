install:
	pip install -r requirements.txt
dev-run:
	uvicorn main:app --host 0.0.0.0 --reload
from .celery import app


@app.task
def task_name():
    pass

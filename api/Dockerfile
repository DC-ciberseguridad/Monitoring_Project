FROM public.ecr.aws/lambda/python:3.11

# Copiar el código
COPY app/ /var/task/

# Instalar dependencias
COPY app/requirements.txt .
RUN pip install -r requirements.txt

# Comando para Lambda (AWS buscará el objeto 'handler' en 'app.py')
CMD [ "app.handler" ]
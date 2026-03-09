FROM hashicorp/terraform:1.5.0

COPY ./terraform /app
WORKDIR /app

CMD ["sh"]

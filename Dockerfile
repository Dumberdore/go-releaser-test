FROM public.ecr.aws/lambda/provided:al2
COPY go-releaser-test /main
ENTRYPOINT [ "/main" ]

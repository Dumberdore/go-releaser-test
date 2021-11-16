FROM public.ecr.aws/lambda/provided:al2
COPY {{.App}} /main
ENTRYPOINT [ "/main" ]

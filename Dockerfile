FROM public.ecr.aws/lambda/provided:al2
COPY {{.ProjectName}} /main
ENTRYPOINT [ "/main" ]

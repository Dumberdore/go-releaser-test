FROM public.ecr.aws/amazonlinux/amazonlinux:latest
COPY go-releaser-test /usr/bin/go-releaser-test
ENTRYPOINT [ "bash", "/usr/bin/go-releaser-test" ]

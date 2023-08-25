# 배포 매뉴얼

마지막 작성 날짜: 2023-08-25
작성자: 김예진

> **목차**
>
> 1. [요구사항](#1-요구사항)
>    1. [기본 요구사항](#기본-요구사항)
>    2. [WeHee 서버 실행 요구사항](#wehee-서버-실행-요구사항)
> 2. [EC2 서버 접속](#2-ec2-서버-접속)
>    1. [Windows에서 접속](#windows에서-접속)
>    2. [Mac에서 접속](#mac에서-접속)
>    3. [IntelliJ Big Data Tools로 접속](#intelllij-big-data-tools로-접속)
> 3. [배포](#3-배포)
>    1. [Backend 배포하기](#backend-배포하기)
>    2. [Frontend 배포하기](#frontend-배포하기)
>    3. [3rd party 배포하기](#3rd-party-배포하기)

### EC2 배포 안내

> [EC2 배포 안내]
>
> 9기 공통 프로젝트 클라우드 서버 안내드립니다.
>
> - 제공기간: 금일 ~ 공통 프로젝트 종료 시(종료 후 7일 이내 삭제 예정)
> - 서버 도메인: i9[팀ID].p.ssafy.io
> - 접속 방법: 제공된 인증키(.pem)를 사용하여 ubuntu 계정으로 SSH 접속서울1반 1팀의 CLI 접속 예: ssh -i I9A101T.pem [ubuntu@i9a101.p.ssafy.io](mailto:ubuntu@i9a101.p.ssafy.io)
>
> ※ 주의 사항 별도의 웹 콘솔 제공되지 않으며 원격 터미널만 접속 가능하므로 방화벽 설정에 주의 방화벽 기본 설정: 활성, 22번 포트만 접속 가능(첨부된 UFW 포트설정하기 참조)
>
> /home 및 시스템 디렉토리의 퍼미션 임의 변경 금지 퍼블릭 클라우드의 서버는 외부에서 쉽게 접근 가능하므로 중요한 파일 저장 및 계정, DB 등의 패스워드 설정에 주의 SSH 포트 차단, 공개키 삭제, 퍼미션 임의 변경 등으로 접속 불가 시 또는 해킹, 악성코드 감염 시 복구 불가(초기화 요청만 가능)

---

# 1. 요구사항

## 기본 요구사항

- [x] well-known 포트 유지?
  - [ ] OpenVidu용 nginx가 host nework 모드로 실행돼 웹서버가 80, 443 포트를 사용할 수 없는 상태
- [x] 방화벽 유지? (ufw)
- [ ] 인증서
- [ ] Https

## WeHee 서버 실행 요구사항

| 외부 개발 | 자체 개발 - 백엔드 | 자체 개발 - 프론트 |
| --------- | ------------------ | ------------------ |
| MySQL     | JVM + JAR          | Node + frontend    |
| Redis     |                    |                    |
| Cassandra |                    |                    |
| RabbitMQ  |                    |                    |

# 2. EC2 서버 접속

## Windows에서 접속

``` bash
ssh -i <pem키 파일> ubuntu@<도메인>
```

## Mac에서 접속

``` bash
cd .ssh
```

``` bash
ssh i- <pem키 파일> ubuntu@<도메인>
```

## IntelliJ Big Data Tools로 접속

[IntelliJ Big Data Tools로 EC2 접속하기](../research/infra/intellij-ec2.md)를 참고해 IntelliJ로 EC2에 접속

# 3. 배포

## Backend 배포하기

1. EC2 인스턴스에 백엔드 배포 환경 구축
   1. `/home/<username>/backend` 폴더 생성
   2. `/home/<username>/backend/libs` 폴더 생성
2. EC2 인스턴스에 빌드 파일 업로드
   1. 로컬에서 [백엔드 배포하기](build-backend.md)를 참고해 빌드 수행
   2. 로컬 `build/libs` 폴더의 프로젝트 jar 파일을 EC2 서버의 `/home/<username>/backend/libs` 하단에 업로드
   3. Spring Boot 프로젝트 실행을 위한 `application.yml` 파일과 `.env` 파일을 `/home/<username>/backend/libs` 하단에 업로드
3. `entrypoint.sh` 파일 생성
   `/home/<username>/backend/libs` 하단에 저장
   ``` sh
   #!/bin/bash
   
   cd /home/libs
   
   set -eux
   
   export $(cat .env | xargs)
   java -jar <jar file>
   ```
4. jar 파일 실행을 위한 도커 파일 만들기
   `/home/<username>/backend/docker-compose.yaml`로 저장
   
   ```
   version: "3.8"
   services:
     backend:
       image: docker.io/library/openjdk:19-ea-19-jdk-slim-buster
       network_mode: host
       volumes:
         - ./libs:/home/libs
       command:
         - /home/libs/entrypoint.sh
   ```
5. 실행
   ```bash
   cd /home/<username>/backend
   ```
   ``` bash
   docker compose stop
   ```
   ``` bash
   docker compose start
   ```

## Frontend 배포하기

1. EC2 인스턴스에 프론트엔드 배포 환경 구축
   1. `/home/<username>/frontend` 폴더 생성
   2. `/home/<username>/frontend/libs` 폴더 생성
2. EC2 인스턴스에 빌드 파일 업로드
   1. 로컬에서 [프론트엔드 배포하기](build-frontend.md)를 참고해 빌드 수행
   2. 로컬 `build` 폴더 내부 파일을 EC2 서버의 `/home/<username>/frontend/libs/build` 폴더로 업로드
3. `entrypoint.sh` 파일 생성
   `/home/<username>/frontend/libs` 하단에 저장
   ```sh
   #!/bin/bash
   
   cd /home/libs
   
   set -eux
   
   npm install -g serve
   serve build
   ```
4. Node.js 실행을 위한 도커 파일 만들기
   `/home/<username>/frontend/docker-compose.yaml`로 저장

   ``` yaml
   version: "3.8"
   services:
     backend:
       image: docker.io/library/node:18.17.1-bullseye
       ports:
         - 3000:3000
       volumes:
         - ./libs:/home/libs
       command:
         - /home/libs/entrypoint.sh
   ```
5. 실행
   ```bash
   cd /home/<username>/frontend
   ```
   ``` bash
   docker compose stop
   ```
   ``` bash
   docker compose start

## 3rd party 배포하기

1. EC2 인스턴스에 3rd party 배포 환경 구축
   `/home/<username>/third-party` 폴더 생성
2. 3rd party 실행을 위한 도커 파일 만들기
   `/home/<username>/third-party/docker-compose.yaml`로 저장
   ``` yaml
   version: '3.8'
   services:
     redis:
       image: "redis:7.0"
       ports:
         - "6379:6379"
       volumes:
         - ./redis/data:/var/lib/mysql
         - ./redis/data/redis.conf:/var/lib/redis/redis.conf
       command: redis-server /var/lib/redis/redis.conf
     mysql:
       image: "mysql:8.0.34"
       restart: always
       ports:
         - "3306:3306"
       environment:
         MYSQL_USER: "${MYSQL_USER}"
         MYSQL_PASSWORD: "${MYSQL_PASSWORD}"
         MYSQL_DATABASE: "${MYSQL_DATABASE}"
         MYSQL_ROOT_PASSWORD: "${MYSQL_ROOT_PASSWORD}"
         TZ: Asia/Seoul
       command:
         - --character-set-server=utf8mb4
         - --collation-server=utf8mb4_unicode_ci
       volumes:
         - ./mysql-init-files/:/docker-entrypoint-initdb.d/
         - ./mysql/data:/var/lib/mysql
     rabbitmq-stomp:
       image: "rabbitmq:3.12"
       ports:
         - "5672:5672"
         - "15672:15672"
         - "61613:61613"
   ```
3. `docker-comose.yaml` 환경변수 설정을 위한 `.env` 파일 업로드
   `home/<username>/third-party/.env`로 업로드
4. 실행
   ```bash
   cd /home/<username>/third-party
   ```
   ``` bash
   docker compose stop
   ```
   ``` bash
   docker compose start
   ```

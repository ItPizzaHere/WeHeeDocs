# 배포 매뉴얼

마지막 작성 날짜: 2023-08-13
작성자: 김예진

> **목차**
>
> 1. [기본 요구사항](#1-기본-요구사항)
> 2. [WeHee 서버 실행 요구사항](#2-wehee-서버-실행-요구사항)
>    1. [외부 개발](#외부-개발)
>    2. [자체 개발 - 백엔드](#자체-개발---백엔드)
>    3. [자체  개발 - 프론트](#자체-개발---프론트)
> 3. [배포](#3-배포)
>    1. [Backend 배포하기](#backend-배포하기)
>    2. [Frontend 배포하기](#frontend-배포하기)

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

# 1. 기본 요구사항

- [x] well-known 포트 유지?
  - [ ] OpenVidu용 nginx가 host nework 모드로 실행돼 웹서버가 80, 443 포트를 사용할 수 없는 상태
- [x] 방화벽 유지?(ufw)
- [ ] 인증서
- [ ] Https

# 2. WeHee 서버 실행 요구사항

## 외부 개발

1. Mysql
2. Redis
3. Cassandra
4. RabbitMQ
5. OpenVidu

## 자체 개발 - 백엔드

1. JVM + JAR

## 자체 개발 - 프론트

1. Node + frontend

# 3. 배포

## Backend 배포하기

1. 빌드: ./gradlew bootJar
2. 업로드: Libs 폴더의 .jar /home/ubuntu/backend/libs 로 업로드하기 (sftp, ftp, S3, Intellij 아무거나)
3. 실행
   1. cd /home/ubuntu/backend
   2. docker compose stop
   3. docker compose start

## Frontend 배포하기

1. 빌드: npm i && npm run build
2. 업로드: build 폴더를 /home/ubuntu/frontend/libs/build 폴더로 업로드
3. 실행
   1. cd /home/ubuntu/frontend
   2. docker compose stop
   3. docker compose start

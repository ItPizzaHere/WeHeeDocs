# Spring WebSocket

마지막 업데이트 날짜: 2023-08-01 <br>
작성자: 김예진

> **목차**
>
> 1. 배워야 할 개념들
>
>    1. STOMP
>
>    2. SockJS
>
>    3. RabbitMQ
>
>    4. Message Brocker
>
>    5. WebSockek
>
>    6. amqp
>
>    7. docker compose file
>
>       [여기](https://github.com/skylove308/playground) 참고함
>
>    8. yml
>
>       1. [yml 프로퍼티 관리](https://tecoble.techcourse.co.kr/post/2022-10-04-active_profiles/)
>       2. [Spring boot 외부 환경변수 주입](https://velog.io/@crow/Spring-boot-%EC%99%B8%EB%B6%80-%ED%99%98%EA%B2%BD%EB%B3%80%EC%88%98-%EC%A3%BC%EC%9E%85)
>
> 2. 의존성 추가

# 1. 의존성 추가

dependency에 해당 내용 추가

`implementation 'org.springframework.boot:spring-boot-starter-websocket'`



# 2. 도커

$ docker-compose -f docker-compose/dependencies.yml up

mysql 실행: docker exec -it <mysql container name> bash

mysql -u root -p

rabbitmq 접근: docker exec <rabbitmq container name> rabbitmq-plugins enable rabbitmq_management

# 3. 단순 WebSocket Test

![](images/dev01.PNG)
![](images/dev02.PNG)

------

### 참고 링크

- [Spring Websocket & STOMP](https://brunch.co.kr/@springboot/695#:~:text=STOMP%EB%8A%94%20Simple%20Text%20Oriented,%ED%95%98%EA%B2%8C%20%EC%A0%95%EC%9D%98%ED%95%A0%20%EC%88%98%20%EC%9E%88%EB%8B%A4.)
  - [Spring AMQP, RabbitMQ](https://brunch.co.kr/@springboot/298)
  - [스프링 클라우드, MQ 도입 사례 시리즈](https://brunch.co.kr/@springboot/2)
    - 도입 배경 및 아키텍처 결정
    - 관련 연구 1 - 기본 개념
    - 관련 연구 2 - RabbitMQ
    - 관련 연구 3 - Spring Cloud Stream, RabbitMQ 연동
- [Spring Official Docs - Flow of Messages](https://docs.spring.io/spring-framework/reference/web/websocket/stomp/message-flow.html)
- [[Spring Boot] WebSocket과 채팅 (1)](https://dev-gorany.tistory.com/212)
- [[Spring Boot] WebSocket과 채팅 (2) - SockJS](https://dev-gorany.tistory.com/224)
- [[Spring Boot] WebSocket과 채팅 (3) - STOMP](https://dev-gorany.tistory.com/235)
- [[Spring Boot] WebSocket과 채팅 (4) - RabbitMQ](https://dev-gorany.tistory.com/325)
- [Spring +STOMP+SOCKJS 채팅 구현(STOMP 작동방식)](https://nobase2dev.tistory.com/25)
- [[Spring][WebSocket] 스프링 STOMP와 웹 소켓 개념 및 사용법 (Web Socket with STOMP) (1)](https://growth-coder.tistory.com/157)
- [Spring Boot WebSocket (2) - 웹소켓 이해하기 _ STOMP로 채팅 고도화 하기](https://ws-pace.tistory.com/106)
- [[Stomp] Spring Boot with React 채팅 서버 : 3-1. Stomp 정리 및 설명](https://develop123.tistory.com/76)

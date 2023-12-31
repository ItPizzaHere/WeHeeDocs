# 채팅 기능 구현하기

마지막 업데이트 날짜: 2023-08-11 <br>
작성자: 김예진

> **목차**
>
> 1. [요구사항 파악](#1-요구사항-파악)
>    1. [채팅 메인](#채팅-메인)
>    2. [채팅 메인 (필터링 및 검색)](#채팅-메인-필터링-및-검색)
>    3. [채팅 참여 목록](#채팅-참여-목록)
>    4. [채팅 생성](#채팅-생성)
>    5. [채팅 강제 퇴장](#채팅-강제-퇴장)
>    6. [채팅 정보 수정 (채팅 생성자)](#채팅-정보-수정-채팅-생성자)
>    7. [채팅 정보 열람 (일반 참여자)](#채팅-정보-열람-일반-참여자)
>    8. [공지사항](#공지사항)
>    9. [채팅 종료](#채팅-종료)
> 2. [Redis 환경 설정](#2-redis-환경-설정)
>    1. [`dockder-compose` 설정](#2-1-docker-compose-설정)
>    2. [Redis-Spring Boot 환경 설정](#2-2-redis---spring-boot-환경-설정)
>       1. [`build.grade` 설정](#buildgradle-설정)
>       2. [`application.yml` 설정](#applicationyml-설정)
>       3. [RedisConfig.java](##redisconfigjava)
> 3. RabbitMQ 환경설정
>    1. 내용
>
> 4. Chatting은 어떻게 만들어서 저장되는가? - Redis 관점
> 5. Love on Chat 메인 화면
> 6. [기타](#기타)
>

# 1. 요구사항 파악

## 채팅 메인

![](images/dev41.png)

- 로그인 한 사용자만이 채팅 게시판을 조회할 수 있다.
- 사용자들은 **생성순**으로 채팅방 목록을 조회할 수 있다.
- 마이페이지에서 설정한 조건(MBTI, 연령, 성별)에 해당하는 채팅방만 조회할 수 있다.
- 사용자들은 채팅방 제목 내 포함되는 단어로 채팅방을 검색할 수 있다.

## 채팅 메인 (필터링 및 검색)

![](images/dev42.png)

## 채팅 참여 목록

![](images/dev43.png)

- 채팅 리스트는 채팅장 왼쪽에 정렬된다.
- 최대 참여 가능한 채팅방 수는 5개이다.
- 채팅방에서 ‘뒤로 가기’를 누르면 퇴장하지는 않지만 창이 닫힌다.
- 채팅 리스트는 최근 메시지 순으로 정렬된다.
- 리스트 상에서 채팅방을 삭제하면 자동으로 해당 채팅방에서 나가진다.

## 채팅 생성

![](images/dev44.png)

- 사용자들은 채팅방을 생성할 수 있다.
- 채팅방 생성 시 채팅방 제목(최대 30자)과 인원 수를 입력해야 한다.
  - 초기 설정 값은 10명이며, 1명부터 10명까지 자유롭게 설정할 수 있다.
- 채팅방 생성 시 조언을 구하고자 하는 MBTI(최소 1개, 최대 3개), 카테고리를 선택해야 한다.
- 채팅방 생성 시 조언을 얻고자 하는 연령대를 범위를 설정해야 한다.
- 채팅방 생성 시 조언을 얻고자 하는 성별을 남, 여, 모두 중 선택해야 한다.
- 채팅방 생성을 한 이후 채팅방 제목 및 인원 수를 수정할 수 있다.

## 채팅 강제 퇴장

![](images/dev45.png)

- 방장은 특정 사용자를 강제 퇴장 시킬 수 있다.
  - 강제 퇴장당한 사용자에게 ‘강제 퇴장 당하였습니다. 24시간 후에 채팅방이 사라집니다.’라는 문구가 보여진다.

## 채팅 정보 수정 (채팅 생성자)

![](images/dev46.png)

- 채팅방을 생성한 사용자는 생성 이후 채팅방 정보를 수정할 수 있다.
- 초기에 지정했던 MBTI는 수정이 불가능하다.
- 채팅방 인원은 현재 채팅방 내 인원 이상, 10명 이하로 수정할 수 있다.

## 채팅 정보 열람 (일반 참여자)

![](images/dev47.png)

## 공지사항

![](images/dev48.png)

## 채팅 종료

![](images/dev49.png)

- 사용자들은 자유롭게 채팅방에서 퇴장할 수 있다.
- ‘나가기’버튼을 누른 후 경고창에 확인을 눌러야 퇴장이 가능하다.
- 채팅방에서 나가면 채팅방 내 메시지를 조회할 수 없다.
- 방장이 채팅방을 종료하면 채팅이 종료된다.
  - 방장을 제외한, 채팅에 참여한 사용자들에게 ‘채팅이 종료되었습니다. 24시간 후에 채팅방이 사라집니다.’라는 문구가 보여진다.
  - 채팅이 종료되면 24시간 동안은 방에 입장할 수 있지만, 24시간 이후 방이 사라진다.
- 방장은 특정 사용자를 강제 퇴장 시킬 수 있다.
  - 강제 퇴장당한 사용자에게 ‘강제 퇴장 당하였습니다. 24시간 후에 채팅방이 사라집니다.’라는 문구가 보여진다.

# 2. Redis 환경 설정

## 2-1. `docker-compose` 설정
`docker-compose/dependencies.yml`에 redis 관련 설정 추가

```yaml
version: '3.8'
services:
  redis:
    image: "redis:7.0"
    ports:
      - "6379:6379"
```

## 2-2. Redis - Spring Boot 환경 설정 

### `build.gradle` 설정

```groovy
# 의존성 추가
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-data-redis:3.1.2'
}
```

### `application.yml` 설정

```yaml
spring:
  data:
    redis:
      host: ${REDIS_HOST}
      port: 6379
```

### RedisConfig.java

```java
@Configuration
public class RedisConfig {

    @Value("${spring.data.redis.host")
    private String host;

    @Value("${spring.data.redis.port")
    private int port;

    @Bean
    public RedisConnectionFactory redisConnectionFactory() {
        return new LettuceConnectionFactory(host, port);
    }
}
```

# 3. RabbitMQ 환경설정

## 3-1. `docker-compose` 설정
`docker-compose/dependencies.yml`에 redis 관련 설정 추가

```yaml
version: '3.8'
services:
  rabbitmq-stomp:
    image: "rabbitmq:3.12"
    ports:
      - "5672:5672"
      - "15672:15672"
      - "61613:61613"
```

## 3-2. Redis - Spring Boot 환경 설정 

### `build.gradle` 설정

```groovy
# 의존성 추가
dependencies {
	implementation 'org.springframework.boot:spring-boot-starter-websocket'
	implementation 'org.springframework.boot:spring-boot-starter-amqp'
	implementation 'org.springframework.boot:spring-boot-starter-reactor-netty'
}
```

## 3-3. WebSocketConfig class 설정

```java
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Value("${wehee.chat.relay.host}")
    private String relayHost;

    @Value("${wehee.chat.relay.port}")
    private Integer relayPort;

    @Value("${wehee.chat.stomp.username}")
    private String stompId;

    @Value("${wehee.chat.stomp.username}")
    private String stompPassword;

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws")
                .setAllowedOrigins("*");
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.setApplicationDestinationPrefixes("/chatroom")
                .enableStompBrokerRelay("/queue/", "/topic/")
                .setUserDestinationBroadcast("/topic/unresolved.user.dest")
                .setUserRegistryBroadcast("/topic/registry.broadcast")
                .setRelayHost(relayHost)
                .setVirtualHost("/")
                .setRelayPort(relayPort)
                .setClientLogin(stompId)
                .setClientPasscode(stompPassword);
    }
}
```



# 기타

### ProjectInitializer.java

```java
@RequiredArgsConstructor
@Component
public class ProjectInitializer implements CommandLineRunner {

    @Override
    public void run(String... args) throws Exception {
        System.out.println("Application started! This code will run on startup.");
    }
}
```

implementation 'org.springframework.data:spring-data-cassandra:4.1.2'

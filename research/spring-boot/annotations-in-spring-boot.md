# Annotations in Spring Boot

마지막 업데이트 날짜: 2023-08-11
작성자: 김예진

- **@AuthenticationPrincipal**: javascript에서 따로 해당 변수를 보내지 않고 createWithAuth(url, options), interceptor 등 내부적인 기능을 거쳐 보냄
- **@Valid**: Entity 내부에 설정한 필드 annotation에 대한 검증 수행
- **@RequestBody**: 프엔에서 사용한 객체 전달
- **@ModelAttribute**: HTTP로 넘어온 값들을 자동으로 바인딩
- **@MessageMapping**: annotated methods will react only to the `SEND` messages with the destination having prefix `/app` and matching the topic set in the annotation
- **@SubscribeMapping**: annotated methods will react only to the `SUBSCRIBE` messages with the destination matching the topic set in the annotation.
- **@RequestParam**: URL에 전달되는 파라미터를 메소드의 인자와 매칭시켜, 파라미터를 받아서 처리할 수 있는 Annotation으로 아래와 같이 사용합니다. Json 형식의 Body를 MessageConverter를 통해 Java 객체로 변환시킵니다.

  ```java
  @Controller                   // 이 Class는 Controller 역할을 합니다
  @RequestMapping("/user")      // 이 Class는 /user로 들어오는 요청을 모두 처리합니다.
  public class UserController {
      @RequestMapping(method = RequestMethod.GET)
      public String getUser(@RequestParam String nickname, @RequestParam(name="old") String age {
          // GET method, /user 요청을 처리
          // https://naver.com?nickname=dog&old=10
          String sub = nickname + "_" + age;
          ...
      }
  }
  ```
-  **@AllArgsConstructor**: 파라미터가 없는 기본 생성자를 생성
-  **@NoArgsConstructor**: 모든 필드 값을 파라미터로 받는 생성자를 만듦
-  **@RequiredArgsConstructor**:  final이나 @NonNull인 필드 값만 파라미터로 받는 생성자 만듦



### @AllArgsConstructor와 @NoArgsConstructor에서 access = AccessLevel.PRIVATE의 의미





### @MessageMapping과 @SubscribeMapping 차이

1. [@SubscribeMapping vs @MessageMapping - stack overflox](https://stackoverflow.com/questions/52999004/subscribemapping-vs-messagemapping)

   > There are several types of STOMP commands that a client may send, among them are `SUBSCRIBE` and `SEND`.
   >
   > A method annotated with `@SubscribeMapping("/topic/topic1")` will receive only `SUBSCRIBE` messages with the destination `"/topic/topic1"`. I.e. when client subscribes to the topic `"/topic/topic1"`, this method will be called.
   >
   > When, on the contrary, the client sends `SEND` message to the `"/topic/topic1"` destination, this method won't be called.
   >
   > A method annotated with `@MessageMapping("/topic2")` will be called for `SEND` messages sent to the `"/app/topic2"` destination and, by default, will send the result to the destination `"/topic/topic2"`.
   >
   > The logic is that client first `CONNECT`s, then `SUBSCRIBE`s to some topics and receives messages sent to these topics by the server (or other clients). It may also `SEND` some messages to some topics. Then it may `UNSUBSCRIBE` and `DISCONNECT`. The process of message exchange is managed by message broker which can be a simple in-memory object or some advanced product, like `ActiveMQ` or `RabbitMQ` etc.
2. 블로그 글 정리

   1. @Controller에서 메시지 핸들링하기
      - @SubscribeMapping
        - 여기에서의 반환값은 연결된 클라이언트에게 직접 메시지로 보내지며 브로커를 통과하지 않는다
        - 메시지를 구독하는 것, 입력하는 url 앞에 /sub가 생략되었다고 생각하면 됨
      - @MessageMapping
        - 메시지를 발행하는 것, 입력하는 url 앞에 /pub가 생략되었다고 생각하면 됨
   2. 출처
      1. [Spring websocket으로 간단 채팅 프로그램 만들기](https://rmcodestar.github.io/websocket/2019/02/11/spring-websocket/)
      2. [STOMP 기반 실시간 채팅 기능 구현 - Wondder 프로젝트 Refactoring (1)](https://great-park.tistory.com/140)
3. dasd







---

### 참고자료

- [스프링(Spring)에서 자주 사용하는 Annotation 개념 및 예제 정리](https://melonicedlatte.com/2021/07/18/182600.html)










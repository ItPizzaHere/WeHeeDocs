# 스프링 부트 환경 설정

마지막 업데이트 날짜: 2023-08-02 <br>
작성자: 김예진

> **목차**

### build.gradle - configuration exclude

```groovy
configurations {
    all*.exclude group: 'org.springframework.boot', module: 'spring-boot-starter-logging'
    all*.exclude group: 'org.springframework.boot', module: 'logback-classic'
}
```

Spring Boot에서 의존성을 추가하면서 의도치 않게 다운 받은 jar 설정 파일을 제거하는 기능을 수행한다.
| 사용자(user) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| ID(식별자) | user_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 닉네임 | nickname | VARCHAR(10) | FK REFERENCES mbti_id(MBTI), NOT NULL |
| MBTI | user_mbti_id | INT | NOT NULL |
| 프로필 사진 URL | profile_url | VARCHAR(255) | DEFAULT NULL |
| 생년 | birth | INT UNSIGNED | NOT NULL |
| 성별 | gender | VARCHAR(1) | NOT NULL |
| 마지막 MBTI 변경일 | last_mbti_modified | DATE | DEFAULT NULL |
| 생년 변경여부 | birth_changed | BOOL | DEFAULT FALSE |
| 성별 변경여부 | gender_changer | BOOL | DEFAULT FALSE |
| provider(네이버, 카카오, 구글 등) | provider | VARCHAR(10) | VARCHAR(10) NOT NULL |
| 식별자 | provider_id | VARCHAR(255) | VARCHAR(255) NOT NULL |
| 탈퇴여부 | withdrawal | BOOL | DEFAULT FALSE |

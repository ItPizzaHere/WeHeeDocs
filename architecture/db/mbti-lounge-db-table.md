[user, 라운지 ERD](https://www.erdcloud.com/d/98PARD72QWATyZNbN)

| MBTI | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| MBTI번호 | mbti_id | INT | PK |
| MBTI | name | VARCHAR(4) | NOT NULL |


| 게시글(post) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 글번호 | post_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 라운지번호 | post_mbti_id | INT | FK REFERENCES MBTI(mbti_id), NOT NULL |
| 제목 | title | VARCHAR(30) | NOT NULL |
| 내용 | content | TEXT | NOT NULL |
| 작성자 | post_user_id | INT UNSIGNED | FK REFERENCES user(user_id) ON DELETE CASCADE |
| 좋아요수 | like_count | MEDIUMINT | NOT NULL DEFAULT 0 |
| 조회수 | hit | INT UNSIGNED | NOT NULL DEFAULT 0 |
| 댓글수 | comment_count | INT UNSIGNED | NOT NULL DEFAULT 0 |
| 게시시간 | upload_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| 상태 | state | INT | NOT NULL DEFAULT 0 |

게시상태: 0=정상, 1=사용자가 직접 삭제, 2=사용자 탈퇴로 인한 삭제, 3=신고 누적으로 인한 삭제


| 좋아요(like) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 좋아요번호 | like_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 게시글번호 | like_post_id | INT UNSIGNED | FK REFERENCES post(post_id) ON DELETE CASCADE |
| 사용자ID | like_user_id | INT UNSIGNED | FK REFERENCES user(user_id) ON DELETE SET NULL |


| 스크랩(scrap) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 스크랩번호 | scrap_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 게시글번호 | scrap_post_id | INT UNSIGNED | FK REFERENCES post(post_id) ON DELETE CASCADE |
| 사용자 | scrap_user_id | INT UNSIGNED | FK REFERENCES user(user_id) ON DELETE SET CASCADE |


| 댓글(comment) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 댓글번호 | comment_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 게시글번호 | comment_post_id | INT UNSIGNED | FK REFERENCES post(post_id) ON DELETE CASCADE |
| 작성자 | comment_user_id | INT UNSIGNED | FK REFERENCES user(user_id) ON DELETE SET NULL |
| 내용 | content | TEXT | NOT NULL |
| 게시시각 | upload_time | TIMESTAMP | NOT NULL DEFAULT CURRENT_TIMESTAMP |
| 게시상태 | state | INT | NOT NULL DEFAULT 0 |

게시상태: 0=정상, 1=사용자가 직접 삭제, 2=사용자 탈퇴로 인한 삭제, 3=신고 누적으로 인한 삭제


| 답글(reply) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 답글번호 | reply_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 댓글번호 | reply_comment_id | INT UNSIGNED | FK REFERENCES comment(comment_id) ON DELETE CASCADE |
| 게시글번호 | reply_post_id | INT UNSIGNED | FK REFERENCES post(post_id) ON DELETE CASCADE |
| 작성자 | reply_user_id | INT UNSIGNED | FK REFERENCES user(user_id) ON DELETE SET NULL |
| 내용 | content | TEXT | NOT NULL |
| 게시시각 | upload_time | TIMESTAMP | NOT NULL DEFAULT CURRENT_TIMESTAMP |
| 게시상태 | state | INT | NOT NULL DEFAULT 0 |

게시상태: 0=정상, 1=사용자가 직접 삭제, 2=사용자 탈퇴로 인한 삭제, 3=신고 누적으로 인한 삭제


| 투표(vote) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 투표번호 | vote_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 제목 | title | VARCHAR(255) | NOT NULL |
| 투표 작성자 | vote_user_id | INT UNSIGNED | FK REFERENCES user(user_id) ON DELETE SET NULL |
| 게시시각 | upload_time | TIMESTAMP | NOT NULL DEFAULT CURRENT_TIMESTAMP |
| 선택지1 | select1 | VARCHAR(255) | NOT NULL |
| 선택지2 | select2 | VARCHAR(255) | NOT NULL |


| 투표자(voter) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | voter_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 투표번호 | voter_vote_id | INT UNSIGNED | FK REFERENCES vote_id(vote) ON DELETE CASCADE |
| 선택번호 | voter_select_id | INT UNSIGNED | NOT NULL |
| 사용자 | voter_user_id | INT UNSIGNED | FK REFERENCES user_id(user) ON DELETE SET NULL |


| 인기게시판(hot_post) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 게시글번호 | hot_post_id | INT UNSIGNED | PK, FK REFERENCES post(post_id) ON DELETE CASCADE |
| 순위 | rank | INT | UNIQUE |


| 알림(notification) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 알림번호 | notification_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 사용자(알림 받는 사람) | notification_receiver_user_id | INT UNSIGNED | FK REFERENCES user_id(user) ON DELETE CASCADE |
| 댓글/대댓글 작성자(알림 울리게 한 사람) | notification_sender_user_id | INT UNSIGNED | FK REFERENCES user_id(user) ON DELETE SET NULL |
| 댓글/대댓글 작성내용 | comment | TEXT | NOT NULL |
| 댓글/대댓글 작성시간 | upload_time | TIMESTAMP | NOT NULL |
| 게시글/댓글 여부 | is_post | BOOL | NOT NULL |
| 게시글/댓글 번호 | origin_post_id | INT UNSIGNED | NOT NULL |
| 열람 여부 | browsed | BOOL | NOT NULL, DEFAULT FALSE |


| 신고(declare) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | declare_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 글 유형 | declare_type | INT | NOT NULL |
| 글 번호 | declare_post_id | INT UNSIGNED |  |
| 신고자 | delclare_user_id | INT UNSIGNED | FK REFERENCES user(user_id) ON DELETE SET NULL |


| 삭제된 게시글(deleted_post) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | deleted_post_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 글번호 | post_id | INT UNSIGNED |  |
| 라운지번호 | post_mbti_id | INT |  |
| 제목 | title | VARCHAR(30) |  |
| 내용 | content | TEXT |  |
| 작성자 | post_user_id | INT UNSIGNED |  |
| 좋아요수 | like_count | MEDIUMINT |  |
| 조회수 | hit | INT UNSIGNED |  |
| 댓글수 | comment_count | INT UNSIGNED |  |
| 게시시간 | upload_time | TIMESTAMP |  |
| 게시상태 | state | INT |  |

게시상태: 0=정상, 1=사용자가 직접 삭제, 2=사용자 탈퇴로 인한 삭제, 3=신고 누적으로 인한 삭제


| 삭제된 댓글(deleted_comment) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | deleted_comment_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 댓글번호 | comment_id | INT UNSIGNED |  |
| 게시글번호 | comment_post_id | INT UNSIGNED |  |
| 작성자 | comment_user_id | INT UNSIGNED |  |
| 내용 | content | TEXT |  |
| 게시시각 | upload_time | TIMESTAMP |  |
| 게시상태 | state | INT |  |

게시상태: 0=정상, 1=사용자가 직접 삭제, 2=사용자 탈퇴로 인한 삭제, 3=신고 누적으로 인한 삭제


| 삭제된 답글(deleted_reply) | 컬럼명 | 속성 | 제약조건 |
| --- | --- | --- | --- |
| 고유번호 | deleted_reply_id | INT UNSIGNED | PK, AUTO_INCREMENT |
| 답글번호 | reply_id | INT UNSIGNED |  |
| 댓글번호 | reply_comment_id | INT UNSIGNED |  |
| 게시글번호 | reply_post_id | INT UNSIGNED |  |
| 작성자 | reply_user_id | INT UNSIGNED |  |
| 내용 | content | TEXT |  |
| 게시시각 | upload_time | TIMESTAMP |  |
| 게시상태 | state | INT |  |

게시상태: 0=정상, 1=사용자가 직접 삭제, 2=사용자 탈퇴로 인한 삭제, 3=신고 누적으로 인한 삭제

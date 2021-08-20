CREATE TABLE IF NOT EXISTS user_profile
(
    id         BIGSERIAL PRIMARY KEY,
    first_name TEXT                                      NOT NULL,
    last_name  TEXT                                      NOT NULL,
    email      TEXT UNIQUE                               NOT NULL,
    gender     TEXT CHECK (gender IN ('MALE', 'FEMALE')) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE               NOT NULL
);

CREATE TABLE IF NOT EXISTS youtube_account
(
    id         BIGINT PRIMARY KEY REFERENCES user_profile (id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS youtube_channel
(
    id                 BIGSERIAL PRIMARY KEY,
    youtube_account_id BIGINT                      NOT NULL REFERENCES youtube_account (id),
    channel_name       TEXT UNIQUE                 NOT NULL,
    created_at         TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS channel_subscriber
(
    youtube_account_id BIGINT REFERENCES youtube_account (id),
    youtube_channel_id BIGINT REFERENCES youtube_channel (id),
    created_at         TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    PRIMARY KEY (youtube_account_id, youtube_channel_id)
);

CREATE TABLE IF NOT EXISTS video
(
    id                 BIGSERIAL PRIMARY KEY,
    youtube_channel_id BIGINT REFERENCES youtube_channel (id),
    title              TEXT                        NOT NULL,
    length             FLOAT                       NOT NULL,
    url                TEXT UNIQUE                 NOT NULL,
    category           TEXT                        NOT NULL,
    created_at         TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_like
(
    video_id           BIGINT REFERENCES video (id),
    youtube_account_id BIGINT REFERENCES user_profile (id)
);

CREATE TABLE IF NOT EXISTS video_comment
(
    id                 BIGSERIAL PRIMARY KEY,
    video_id           BIGINT REFERENCES video (id),
    youtube_account_id BIGINT REFERENCES user_profile (id),
    comment            TEXT                        NOT NULL,
    created_at         TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

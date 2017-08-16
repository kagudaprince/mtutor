CREATE TABLE OBSIDIAN.SEQUENCE_MANAGER (
  NAME                 NVARCHAR2(50)                  primary key,
  VALUE             NUMBER(10)                          NOT NULL,
  REVISION            NUMBER(10)                        NOT NULL,
  CREATED_DATE        TIMESTAMP                         NOT NULL,
  CREATED_BY        NVARCHAR2(50)                        NOT NULL,
  LAST_UPDATED_DATE TIMESTAMP                           NOT NULL,
  LAST_UPDATED_BY    NVARCHAR2(50)                       NOT NULL
);


CREATE TABLE OBSIDIAN.SUITE_USER (
 SUITE_USER_ID        NUMBER(10)                    primary key,
 USER_NAME            NVARCHAR2(50)                     NOT NULL,
 PASSWORD            NVARCHAR2(100)                     NOT NULL,
 FIRST_NAME            NVARCHAR2(50)                    NULL,
 LAST_NAME            NVARCHAR2(50)                     NULL,
 EMAIL                NVARCHAR2(50)                     NULL,
 ACTIVE                   NUMBER(1)  default '1'           NOT NULL, 
 REVISION            NUMBER(10)                           NOT NULL,
 CREATED_DATE        TIMESTAMP                         NOT NULL,
 CREATED_BY            NVARCHAR2(50)                   NOT NULL,
 LAST_UPDATED_DATE  TIMESTAMP                          NOT NULL,
 LAST_UPDATED_BY    NVARCHAR2(50)                      NOT NULL
);

CREATE UNIQUE INDEX OBSIDIAN.UK_USER_USER_NAME ON OBSIDIAN.SUITE_USER (USER_NAME);

CREATE TABLE OBSIDIAN.USER_COOKIE (
 USER_COOKIE_ID            NUMBER(10)          primary key,
 USER_NAME            NVARCHAR2(50)             NOT NULL,
 COOKIE                  NVARCHAR2(255)            NOT NULL, 
 USER_STATE           NCLOB                     NOT NULL, 
 REVISION            NUMBER(10)                NOT NULL,
 CREATED_DATE        TIMESTAMP                 NOT NULL,
 CREATED_BY            NVARCHAR2(50)            NOT NULL,
 LAST_UPDATED_DATE  TIMESTAMP                  NOT NULL,
 LAST_UPDATED_BY    NVARCHAR2(50)               NOT NULL
);

CREATE UNIQUE INDEX OBSIDIAN.UK_USER_COOKIE_USER_NAME ON OBSIDIAN.USER_COOKIE (USER_NAME);
CREATE UNIQUE INDEX OBSIDIAN.UK_USER_COOKIE_COOKIE ON OBSIDIAN.USER_COOKIE (COOKIE);


CREATE TABLE OBSIDIAN.ROLE (
 ROLE_ID            NUMBER(10)                    primary key,
 ROLE_NAME            NVARCHAR2(50)                   NOT NULL,
 REVISION            NUMBER(10)                      NOT NULL ,
 CREATED_DATE        TIMESTAMP                       NOT NULL,
 CREATED_BY            NVARCHAR2(50)                  NOT NULL,
 LAST_UPDATED_DATE  TIMESTAMP                        NOT NULL,
 LAST_UPDATED_BY    NVARCHAR2(50)                     NOT NULL
);

CREATE UNIQUE INDEX OBSIDIAN.UK_ROLE_NAME ON OBSIDIAN.ROLE (ROLE_NAME);

CREATE TABLE OBSIDIAN.USER_ROLE (
 USER_ROLE_ID        NUMBER(10)                    primary key,
 SUITE_USER_ID        NUMBER(10)                        NOT NULL,
 ROLE_ID            NUMBER(10)                        NOT NULL,
 REVISION            NUMBER(10)                       NOT NULL ,
 CREATED_DATE        TIMESTAMP                        NOT NULL,
 CREATED_BY            NVARCHAR2(50)                   NOT NULL,
 LAST_UPDATED_DATE  TIMESTAMP                         NOT NULL,
 LAST_UPDATED_BY    NVARCHAR2(50)                      NOT NULL,
 CONSTRAINT OBSIDIAN.FK_USER_USER_ROLE FOREIGN KEY (SUITE_USER_ID) REFERENCES OBSIDIAN.SUITE_USER (SUITE_USER_ID),
 CONSTRAINT OBSIDIAN.FK_USER_ROLE FOREIGN KEY (ROLE_ID) REFERENCES OBSIDIAN.ROLE (ROLE_ID) 
);

CREATE UNIQUE INDEX OBSIDIAN.UK_USER_ROLE ON OBSIDIAN.USER_ROLE (SUITE_USER_ID, ROLE_ID);

CREATE TABLE OBSIDIAN.CUSTOM_CALENDAR (
    CUSTOM_CALENDAR_ID NUMBER(10)           PRIMARY KEY,  
    NAME              NVARCHAR2(100)        NOT NULL,
    DATES              NCLOB                    NOT NULL,
    REVISION          NUMBER(10)            NOT NULL,  
    CREATED_DATE      TIMESTAMP             NOT NULL,  
    CREATED_BY        NVARCHAR2(50)            NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP             NOT NULL,  
    LAST_UPDATED_BY   NVARCHAR2(50)            NOT NULL 
);

CREATE UNIQUE INDEX OBSIDIAN.CUSTOM_CALENDAR_UK_01 ON OBSIDIAN.CUSTOM_CALENDAR (NAME);

CREATE TABLE OBSIDIAN.JOB (  
    JOB_ID          NUMBER(10)                           PRIMARY KEY,  
    JOB_CLASS       NVARCHAR2(255)                      NOT NULL,  
    NICKNAME        NVARCHAR2(255)                       NOT NULL,  
    FOLDER		    NVARCHAR2(255)							 NULL,
    PICKUP_BUFFER_MINUTES    NUMBER(4)     default '2'        NOT NULL,
    RECOVERY_TYPE   NVARCHAR2(20)  default 'NONE'       NOT NULL,  
    MIN_EXECUTION_DURATION NVARCHAR2(15)                    NULL,
    MAX_EXECUTION_DURATION NVARCHAR2(15)                    NULL,
    CHAIN_ALL             NUMBER(1) default '0'            NOT    NULL,
    HOST_PREFERENCE        NUMBER(1) default '0'            NOT    NULL,
    AUTO_INTERRUPT         NUMBER(1) default '0'            NOT    NULL,
    FAILURE_RETRIES     NUMBER(4) default '0'            NOT NULL,
    FAILURE_RETRY_INTERVAL NUMBER(4) default '0'        NOT NULL,
    FAILURE_RETRY_EXPONENT NUMBER(4) default '0'        NOT NULL,
    REVISION            NUMBER(10)     default '0'      NOT NULL,  
    CREATED_DATE        TIMESTAMP                       NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                     NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                         NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                    NOT NULL,  
    CONSTRAINT OBSIDIAN.CHK_JOB_RECOVERY_TYPE CHECK (RECOVERY_TYPE IN ('NONE','ALL','LAST','CONFLICTED'))
);

CREATE UNIQUE INDEX OBSIDIAN.JOB_NICKNAME_UK ON OBSIDIAN.JOB (NICKNAME);
CREATE INDEX OBSIDIAN.JOB_FOLDER_NU ON OBSIDIAN.JOB (FOLDER);

CREATE TABLE OBSIDIAN.JOB_STATE (
    JOB_STATE_ID     NUMBER(10)                        PRIMARY KEY,
    JOB_ID             NUMBER(10)                        NOT NULL,  
    SCHEDULE        NCLOB                      NULL,  
    JOB_STATUS      NVARCHAR2(50)                    NOT NULL,  
    EFFECTIVE_DATE    TIMESTAMP                        NOT NULL,
    END_DATE        TIMESTAMP                        NOT NULL,
    CUSTOM_CALENDAR_ID NUMBER(10)                        NULL,
    REVISION            NUMBER(10)   default '0'    NOT NULL,  
    CREATED_DATE        TIMESTAMP                   NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                 NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                     NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                NOT NULL,  
    CONSTRAINT OBSIDIAN.CHK_STATE_STATUS CHECK (JOB_STATUS IN ('DISABLED','ENABLED','CHAIN ACTIVE','AD HOC ACTIVE','UNSCHEDULED ACTIVE'))  
);

CREATE INDEX OBSIDIAN.JOB_STATE_JOB_ID_NU ON OBSIDIAN.JOB_STATE (JOB_ID);
ALTER TABLE OBSIDIAN.JOB_STATE ADD CONSTRAINT OBSIDIAN.JOB_STATE_JOB_FK FOREIGN KEY (JOB_ID) REFERENCES OBSIDIAN.JOB (JOB_ID);
CREATE INDEX OBSIDIAN.JOB_STATE_CALENDAR_NU ON OBSIDIAN.JOB_STATE (CUSTOM_CALENDAR_ID);
ALTER TABLE OBSIDIAN.JOB_STATE ADD CONSTRAINT OBSIDIAN.JOB_STATE_CAL_FK FOREIGN KEY (CUSTOM_CALENDAR_ID) REFERENCES OBSIDIAN.CUSTOM_CALENDAR (CUSTOM_CALENDAR_ID);

CREATE TABLE OBSIDIAN.JOB_RUNNING_HOST (
    JOB_RUNNING_HOST_ID        NUMBER(10)                        PRIMARY KEY,
    JOB_ID                    NUMBER(10)                        NOT NULL,
    RUNNING_HOST        NVARCHAR2(255)                        NOT NULL,
    REVISION            NUMBER(10)  default '0'             NOT NULL,  
    CREATED_DATE        TIMESTAMP                           NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                         NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                             NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                        NOT NULL  
);

CREATE INDEX OBSIDIAN.JOB_RUNNING_HOST_NU ON OBSIDIAN.JOB_RUNNING_HOST (JOB_ID);
CREATE UNIQUE INDEX OBSIDIAN.JOB_RUNNING_HOST_HOST_UK ON OBSIDIAN.JOB_RUNNING_HOST (JOB_ID, RUNNING_HOST);
ALTER TABLE OBSIDIAN.JOB_RUNNING_HOST ADD CONSTRAINT OBSIDIAN.JOB_RUNNING_HOST_JOB_FK FOREIGN KEY (JOB_ID) REFERENCES OBSIDIAN.JOB (JOB_ID);
    
CREATE TABLE OBSIDIAN.JOB_CONFIGURATION (
    JOB_CONFIGURATION_ID    NUMBER(10)                        PRIMARY KEY,
    JOB_ID                      NUMBER(10)                           NOT NULL,  
    PARAMETER_NAME            NVARCHAR2(50)                      NOT NULL,
    PARAMETER_TYPE            NVARCHAR2(255)                      NOT NULL,
    VALUE                    NCLOB                              NOT NULL,
    REVISION                   NUMBER(10) default '0'            NOT NULL ,  
    CREATED_DATE            TIMESTAMP                         NOT NULL,  
    CREATED_BY                NVARCHAR2(50)                     NOT NULL,  
    LAST_UPDATED_DATE         TIMESTAMP                         NOT NULL,  
    LAST_UPDATED_BY            NVARCHAR2(50)                     NOT NULL  
);

CREATE INDEX OBSIDIAN.JOB_CONFIG_JOB_ID_NU ON OBSIDIAN.JOB_CONFIGURATION (JOB_ID);
ALTER TABLE OBSIDIAN.JOB_CONFIGURATION ADD CONSTRAINT OBSIDIAN.JOB_CONFIG_JOB_FK FOREIGN KEY (JOB_ID) REFERENCES OBSIDIAN.JOB (JOB_ID);
   
CREATE TABLE OBSIDIAN.JOB_HISTORY (  
    JOB_HISTORY_ID         NUMBER(10)                      PRIMARY KEY,  
    JOB_ID                   NUMBER(10)                         NOT NULL,  
    STATUS              NVARCHAR2(20)                   NOT NULL,  
    SCHEDULED_TIME        TIMESTAMP                        NOT NULL,  
    RUNTIME_ORDINAL		NUMBER(4)							NOT NULL,
    RUNNING_HOST        NVARCHAR2(255)                        NULL,
    PICKUP_TIME            TIMESTAMP                            NULL,  
    HEARTBEAT_TIME        TIMESTAMP                            NULL,  
    END_TIME        TIMESTAMP                                NULL,  
    AD_HOC        NUMBER(1) default '0'                    NOT NULL, 
    RESUBMISSION        NUMBER(1) default '0'            NOT NULL, 
    CHAINED_FROM_ID     NUMBER(10)                            NULL,  
    RESUBMITTED_TO_ID     NUMBER(10)                            NULL,  
    SUBMISSION_MODE        NVARCHAR2(20)                       NULL,
    AUTO_RETRY_COUNT    NUMBER(4)                             NULL,
    CHAIN_PROCESSED        NUMBER(1) default '0'            NOT NULL, 
    FAILURES_PROCESSED    NUMBER(1) default '0'            NOT NULL, 
    REVISION            NUMBER(10) default '0'            NOT NULL,  
    CREATED_DATE        TIMESTAMP                       NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                     NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                         NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                    NOT NULL,  
    CONSTRAINT OBSIDIAN.CHK_JOB_HISTORY_STATUS CHECK (STATUS IS NULL OR STATUS IN ('READY','RUNNING','COMPLETED','FAILED','DIED','CONFLICTED','MISSED','ABANDONED','OVERLAPPED','CHAIN SKIPPED','CONFLICT MISSED')),
    CONSTRAINT OBSIDIAN.CHK_JOB_HIST_SUBM_MODE CHECK (SUBMISSION_MODE IS NULL OR SUBMISSION_MODE IN ('CONFLICTED_RECOVERY', 'CHAIN_SUBMISSION'))  
);
    
CREATE INDEX OBSIDIAN.JOB_HISTORY_STATUS_NU ON OBSIDIAN.JOB_HISTORY (STATUS);
CREATE INDEX OBSIDIAN.JOB_HIST_RUNNING_HOST_NU ON OBSIDIAN.JOB_HISTORY (RUNNING_HOST);
CREATE INDEX OBSIDIAN.JOB_HISTORY_JOB_ID_NU ON OBSIDIAN.JOB_HISTORY (JOB_ID);
CREATE INDEX OBSIDIAN.JOB_HIST_CHAINED_FROM_NU ON OBSIDIAN.JOB_HISTORY (CHAINED_FROM_ID);
CREATE INDEX OBSIDIAN.JOB_HIST_RESUBMIT_TO_NU ON OBSIDIAN.JOB_HISTORY (RESUBMITTED_TO_ID);
CREATE UNIQUE INDEX OBSIDIAN.JOB_HIST_SCHED_JOB_UK ON OBSIDIAN.JOB_HISTORY (JOB_ID, SCHEDULED_TIME, RUNTIME_ORDINAL);
CREATE INDEX OBSIDIAN.JOB_HIST_SCHED_TIME_NU ON OBSIDIAN.JOB_HISTORY (SCHEDULED_TIME);
CREATE INDEX OBSIDIAN.JOB_HIST_CHAIN_PRCSD_NU ON OBSIDIAN.JOB_HISTORY (CHAIN_PROCESSED);
CREATE INDEX OBSIDIAN.JOB_HIST_FAIL_PRCSD_NU ON OBSIDIAN.JOB_HISTORY (FAILURES_PROCESSED);
ALTER TABLE OBSIDIAN.JOB_HISTORY ADD CONSTRAINT OBSIDIAN.JOB_HISTORY_JOB_FK FOREIGN KEY (JOB_ID) REFERENCES OBSIDIAN.JOB (JOB_ID);
ALTER TABLE OBSIDIAN.JOB_HISTORY ADD CONSTRAINT OBSIDIAN.JOB_HIST_CHAINED_FROM_FK FOREIGN KEY (CHAINED_FROM_ID) REFERENCES OBSIDIAN.JOB_HISTORY (JOB_HISTORY_ID);
ALTER TABLE OBSIDIAN.JOB_HISTORY ADD CONSTRAINT OBSIDIAN.JOB_HIST_RESUBMIT_TO_FK FOREIGN KEY (RESUBMITTED_TO_ID) REFERENCES OBSIDIAN.JOB_HISTORY (JOB_HISTORY_ID);

CREATE TABLE OBSIDIAN.JOB_HISTORY_ERROR (  
    JOB_HISTORY_ERROR_ID    NUMBER(10)                      PRIMARY KEY,
    JOB_HISTORY_ID             NUMBER(10)                      NOT NULL,  
    EXCEPTION_CLASS            NVARCHAR2(300)                    NOT NULL,
    EXCEPTION_MESSAGE        NVARCHAR2(255)                    NOT NULL,
    ERROR                    NCLOB                            NOT NULL,
    REVISION            NUMBER(10)  default '0'                NOT NULL,  
    CREATED_DATE        TIMESTAMP                           NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                         NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                             NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                        NOT NULL
);

CREATE UNIQUE INDEX OBSIDIAN.JOB_HIST_ERR_HIST_UK_01 ON OBSIDIAN.JOB_HISTORY_ERROR (JOB_HISTORY_ID);
ALTER TABLE OBSIDIAN.JOB_HISTORY_ERROR ADD CONSTRAINT OBSIDIAN.JOB_HIST_ERR_JOB_HIST_FK FOREIGN KEY (JOB_HISTORY_ID) REFERENCES OBSIDIAN.JOB_HISTORY (JOB_HISTORY_ID);

CREATE TABLE OBSIDIAN.JOB_HISTORY_INTERRUPT (  
    JOB_HISTORY_INTERRUPT_ID    NUMBER(10)                      PRIMARY KEY,
    JOB_HISTORY_ID             NUMBER(10)                      NOT NULL,  
    REQUESTER         NVARCHAR2(50)                         NOT NULL,  
    REQUEST_TIME        TIMESTAMP                            NOT NULL,
    INTERRUPT_TIME        TIMESTAMP                                NULL,
    REVISION            NUMBER(10)  default '0'                NOT NULL,  
    CREATED_DATE        TIMESTAMP                           NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                         NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                             NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                        NOT NULL
);

CREATE UNIQUE INDEX OBSIDIAN.JOB_HIST_INTRP_HIS_UK_01 ON OBSIDIAN.JOB_HISTORY_INTERRUPT (JOB_HISTORY_ID);
ALTER TABLE OBSIDIAN.JOB_HISTORY_INTERRUPT ADD CONSTRAINT OBSIDIAN.JOB_HIST_INTRP_HIST_FK FOREIGN KEY (JOB_HISTORY_ID) REFERENCES OBSIDIAN.JOB_HISTORY (JOB_HISTORY_ID);

CREATE TABLE OBSIDIAN.JOB_HISTORY_RESULT (  
    JOB_HISTORY_RESULT_ID   NUMBER(10)                    PRIMARY KEY,
    JOB_HISTORY_ID             NUMBER(10)                    NOT NULL,  
    NAME                    NVARCHAR2(255)                  NOT NULL,
    VALUE                    NCLOB                               NULL,
    VALUE_TYPE                NVARCHAR2(255)                  NOT NULL,
    REVISION                NUMBER(10) default '0'        NOT NULL,  
    CREATED_DATE            TIMESTAMP                       NOT NULL,  
    CREATED_BY                NVARCHAR2(50)                 NOT NULL,  
    LAST_UPDATED_DATE         TIMESTAMP                     NOT NULL,  
    LAST_UPDATED_BY            NVARCHAR2(50)                 NOT NULL
);

ALTER TABLE OBSIDIAN.JOB_HISTORY_RESULT ADD CONSTRAINT OBSIDIAN.JOB_HIST_RES_JOB_HIST_FK FOREIGN KEY (JOB_HISTORY_ID) REFERENCES OBSIDIAN.JOB_HISTORY (JOB_HISTORY_ID);


CREATE TABLE OBSIDIAN.JOB_CHAIN (  
    JOB_CHAIN_ID         NUMBER(10)                      PRIMARY KEY,  
    SOURCE_JOB_ID        NUMBER(10)                         NOT NULL,  
    CHAINED_TO_JOB_ID    NUMBER(10)                         NOT NULL,  
    CHAINING_ENABLED    NUMBER(1) default '1'            NOT NULL,  
    CHAINING_SCHEDULE        NVARCHAR2(255)                    NULL,
    DESCRIPTION            NVARCHAR2(255)                        NULL,
    REVISION            NUMBER(10)  default '0'         NOT NULL,  
    CREATED_DATE        TIMESTAMP                       NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                        NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                         NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                    NOT NULL
);
    
CREATE INDEX OBSIDIAN.JOB_CHAIN_SRC_JOB_ID_NU ON OBSIDIAN.JOB_CHAIN (SOURCE_JOB_ID);
CREATE INDEX OBSIDIAN.JOB_CHAIN_CHN_TO_JOB_NU ON OBSIDIAN.JOB_CHAIN (CHAINED_TO_JOB_ID);
CREATE INDEX OBSIDIAN.JOB_CHAIN_BOTH_JOBIDS_NU ON OBSIDIAN.JOB_CHAIN (SOURCE_JOB_ID, CHAINED_TO_JOB_ID);
ALTER TABLE OBSIDIAN.JOB_CHAIN ADD CONSTRAINT OBSIDIAN.JOB_CHAIN_SOURCE_JOB_FK FOREIGN KEY (SOURCE_JOB_ID) REFERENCES OBSIDIAN.JOB (JOB_ID);
ALTER TABLE OBSIDIAN.JOB_CHAIN ADD CONSTRAINT OBSIDIAN.JOB_CHAIN_CHAINED_TO_FK FOREIGN KEY (CHAINED_TO_JOB_ID) REFERENCES OBSIDIAN.JOB (JOB_ID);

CREATE TABLE OBSIDIAN.JOB_CHAIN_MODE (  
    JOB_CHAIN_MODE_ID   NUMBER(10)                        PRIMARY KEY,  
    JOB_CHAIN_ID         NUMBER(10)                      NOT NULL,  
    STATUS              NVARCHAR2(20)                    NOT NULL,
    REVISION            NUMBER(10)  default '0'         NOT NULL,  
    CREATED_DATE        TIMESTAMP                       NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                        NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                         NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                    NOT NULL,  
    CONSTRAINT OBSIDIAN.CHK_JOB_CHN_MODE_STATUS CHECK (STATUS IN ('FAILED','DIED','KILLED','MISSED','COMPLETED','ABANDONED','OVERLAPPED','CHAIN SKIPPED','CONDITIONAL'))
);
    
CREATE INDEX OBSIDIAN.JOB_CHAIN_MD_CHAIN_ID_NU ON OBSIDIAN.JOB_CHAIN_MODE (JOB_CHAIN_ID);
ALTER TABLE OBSIDIAN.JOB_CHAIN_MODE ADD CONSTRAINT OBSIDIAN.JOB_CHAIN_MODE_CHAIN_FK FOREIGN KEY (JOB_CHAIN_ID) REFERENCES OBSIDIAN.JOB_CHAIN (JOB_CHAIN_ID);

CREATE TABLE OBSIDIAN.JOB_CHAIN_MODE_CONDITION (  
    JOB_CHAIN_MODE_CONDITION_ID   NUMBER(10)            PRIMARY KEY,  
    JOB_CHAIN_MODE_ID         NUMBER(10)                  NOT NULL,  
    CONTEXT_KEY            NVARCHAR2(255)                    NOT NULL,
    OPERATOR            NVARCHAR2(30)                    NOT NULL,
    VALUE                NVARCHAR2(2000)                        NULL,
    REVISION            NUMBER(10)  default '0'         NOT NULL,  
    CREATED_DATE        TIMESTAMP                       NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                        NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                         NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                    NOT NULL,  
    CONSTRAINT OBSIDIAN.CHK_JOB_CHAIN_MD_COND_OP CHECK (OPERATOR IN ('EQUALS','NOT_EQUALS','IN','NOT_IN','GREATER_THAN','LESS_THAN','GREATER_THAN_OR_EQUAL','LESS_THAN_OR_EQUAL','STARTS_WITH','ENDS_WITH','CONTAINS','EXISTS','NOT_EXISTS','REGEXP'))
);

CREATE INDEX OBSIDIAN.JOB_CH_MD_COND_MD_ID_NU ON OBSIDIAN.JOB_CHAIN_MODE_CONDITION (JOB_CHAIN_MODE_ID);
ALTER TABLE OBSIDIAN.JOB_CHAIN_MODE_CONDITION ADD CONSTRAINT OBSIDIAN.JOB_CHAIN_MD_COND_FK FOREIGN KEY (JOB_CHAIN_MODE_ID) REFERENCES OBSIDIAN.JOB_CHAIN_MODE (JOB_CHAIN_MODE_ID);

CREATE TABLE OBSIDIAN.JOB_HISTORY_CHAIN (  
    JOB_HISTORY_CHAIN_ID    NUMBER(10)                    PRIMARY KEY,
    JOB_HISTORY_ID             NUMBER(10)                    NOT NULL,  
    JOB_CHAIN_ID            NUMBER(10)                      NOT NULL,
    CHAIN_TRIGGER            NUMBER(1)                      NOT NULL,
    CHAIN_DETAIL            NVARCHAR2(255)                      NULL,
    REVISION            NUMBER(10)  default '0'           NOT NULL,  
    CREATED_DATE        TIMESTAMP                         NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                       NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                           NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                      NOT NULL
);

CREATE INDEX OBSIDIAN.JOB_HIST_CHAIN_HIS_ID_NU ON OBSIDIAN.JOB_HISTORY_CHAIN (JOB_HISTORY_ID, CHAIN_TRIGGER);
CREATE INDEX OBSIDIAN.JOB_HIST_CHAIN_CHAIN_NU ON OBSIDIAN.JOB_HISTORY_CHAIN (JOB_CHAIN_ID);
CREATE UNIQUE INDEX OBSIDIAN.JOB_HIST_HIST_CHN_UK_01 ON OBSIDIAN.JOB_HISTORY_CHAIN (JOB_HISTORY_ID, JOB_CHAIN_ID);
ALTER TABLE OBSIDIAN.JOB_HISTORY_CHAIN ADD CONSTRAINT OBSIDIAN.JOB_HIST_CHN_JOB_HIST_FK FOREIGN KEY (JOB_HISTORY_ID) REFERENCES OBSIDIAN.JOB_HISTORY (JOB_HISTORY_ID);
ALTER TABLE OBSIDIAN.JOB_HISTORY_CHAIN ADD CONSTRAINT OBSIDIAN.JOB_HIST_CHN_JOB_CHN_FK FOREIGN KEY (JOB_CHAIN_ID) REFERENCES OBSIDIAN.JOB_CHAIN (JOB_CHAIN_ID);

CREATE TABLE OBSIDIAN.JOB_CONFLICT_CONFIG (  
    JOB_CONFLICT_CONFIG_ID         NUMBER(10)              PRIMARY KEY,  
    PRIORITY_JOB_ID                NUMBER(10)                 NOT NULL,  
    YIELDING_JOB_ID                NUMBER(10)                 NOT NULL,
    GROUP_NUMBER                NUMBER(10)                 NOT NULL,
    ORDINAL                     NUMBER(10)                 NOT NULL,
    REVISION            NUMBER(10)  default '0'         NOT NULL,  
    CREATED_DATE        TIMESTAMP                       NOT NULL,  
    CREATED_BY        NVARCHAR2(50)                     NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                         NOT NULL,  
    LAST_UPDATED_BY    NVARCHAR2(50)                    NOT NULL
);

ALTER TABLE OBSIDIAN.JOB_CONFLICT_CONFIG ADD CONSTRAINT OBSIDIAN.JOB_CONFLICT_PRIOR_FK FOREIGN KEY (PRIORITY_JOB_ID) REFERENCES OBSIDIAN.JOB (JOB_ID);
ALTER TABLE OBSIDIAN.JOB_CONFLICT_CONFIG ADD CONSTRAINT OBSIDIAN.JOB_CONFLICT_YIELD_FK FOREIGN KEY (YIELDING_JOB_ID) REFERENCES OBSIDIAN.JOB (JOB_ID);


CREATE TABLE OBSIDIAN.EVENT_LOG (
    EVENT_LOG_ID    NUMBER(10)                PRIMARY KEY,
    EVENT_LEVEL            NVARCHAR2(10)            NOT NULL,
    EVENT_TIME        TIMESTAMP                NOT NULL,
    HOST            NVARCHAR2(100)            NOT NULL,
    CATEGORY        NVARCHAR2(50)            NOT NULL,
    SUMMARY            NVARCHAR2(255)            NOT NULL,
    MESSAGE            NCLOB                        NULL,
    REVISION          NUMBER(10)   default '0'  NOT NULL,   
    CREATED_DATE      TIMESTAMP             NOT NULL,  
    CREATED_BY        NVARCHAR2(50)            NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP             NOT NULL,  
    LAST_UPDATED_BY   NVARCHAR2(50)            NOT NULL
);

CREATE INDEX OBSIDIAN.KEY_LOG_NU_01 ON OBSIDIAN.EVENT_LOG (CATEGORY);
CREATE INDEX OBSIDIAN.KEY_LOG_NU_02 ON OBSIDIAN.EVENT_LOG (HOST);
CREATE INDEX OBSIDIAN.KEY_LOG_NU_03 ON OBSIDIAN.EVENT_LOG (EVENT_TIME, EVENT_LEVEL, CATEGORY, HOST);

CREATE TABLE OBSIDIAN.SEMAPHORE (
    SEMAPHORE_ID    NUMBER(10)                    PRIMARY KEY,
    NAME            NVARCHAR2(50)                            NOT NULL,
    REVISION          NUMBER(10)   default '0'  NOT NULL,    
    CREATED_DATE      TIMESTAMP              NOT NULL,  
    CREATED_BY        NVARCHAR2(50)            NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP              NOT NULL,  
    LAST_UPDATED_BY   NVARCHAR2(50)            NOT NULL
);

CREATE UNIQUE INDEX OBSIDIAN.KEY_SEMAPHORE_UK_01 ON OBSIDIAN.SEMAPHORE (NAME);

CREATE TABLE OBSIDIAN.OPERATIONS_PARAMETER (
    OPERATIONS_PARAMETER_ID    NUMBER(10)                    PRIMARY KEY,
    NAME                NVARCHAR2(255)                            NOT NULL,
    VALUE                    NCLOB                                 NOT NULL,
    TYPE                NVARCHAR2(100)                            NULL,
    CATEGORY            NVARCHAR2(100)                        NOT NULL,
    DESCRIPTION            NVARCHAR2(500)                            NULL,
    EDITABLE            NUMBER(1)                                    NOT NULL,
    UPDATE_TIME            TIMESTAMP                            NOT NULL,
    REVISION          NUMBER(10)   default '0'  NOT NULL,
    CREATED_DATE      TIMESTAMP              NOT NULL,  
    CREATED_BY        NVARCHAR2(50)            NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP              NOT NULL,  
    LAST_UPDATED_BY   NVARCHAR2(50)            NOT NULL
);

CREATE INDEX OBSIDIAN.KEY_OPS_PARAMETER_NU_01 ON OBSIDIAN.OPERATIONS_PARAMETER (NAME);
CREATE INDEX OBSIDIAN.KEY_OPS_PARAMETER_NU_02 ON OBSIDIAN.OPERATIONS_PARAMETER (CATEGORY);


CREATE TABLE OBSIDIAN.EVENT_SUBSCRIBER (
    EVENT_SUBSCRIBER_ID    NUMBER(10)    PRIMARY KEY,
    ADDRESS              NVARCHAR2(255)            NOT NULL,
    ADDRESS_TYPE      NVARCHAR2(20)         NOT NULL, 
    ACTIVE               NUMBER(1) default '1' NOT NULL,
    REVISION          NUMBER(10)   default '0'  NOT NULL,
    CREATED_DATE      TIMESTAMP              NOT NULL,  
    CREATED_BY        NVARCHAR2(50)            NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP              NOT NULL,  
    LAST_UPDATED_BY   NVARCHAR2(50)            NOT NULL, 
    CONSTRAINT OBSIDIAN.CHK_EVENT_SUB_ADDR_TYPE CHECK (ADDRESS_TYPE IN ('EMAIL'))  
);

CREATE UNIQUE INDEX OBSIDIAN.KEY_EVENT_SUB_UK_01 ON OBSIDIAN.EVENT_SUBSCRIBER (ADDRESS, ADDRESS_TYPE);

CREATE TABLE OBSIDIAN.EVENT_SUBSCRIPTION (
    EVENT_SUBSCRIPTION_ID NUMBER(10)  PRIMARY KEY,
    EVENT_SUBSCRIBER_ID    NUMBER(10)    NOT NULL ,
    CATEGORY          NVARCHAR2(255)            NOT NULL,
    ENTITY_ID          NUMBER(10)            NULL,
    MIN_LEVEL          NVARCHAR2(255)            NOT NULL,
    ACTIVE               NUMBER(1) default '1'        NOT NULL,
    REVISION          NUMBER(10)   default '0'  NOT NULL,
    CREATED_DATE      TIMESTAMP              NOT NULL,  
    CREATED_BY        NVARCHAR2(50)            NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP              NOT NULL,  
    LAST_UPDATED_BY   NVARCHAR2(50)            NOT NULL
);

CREATE UNIQUE INDEX OBSIDIAN.KEY_EVENT_SUBSCR_UK_01 ON OBSIDIAN.EVENT_SUBSCRIPTION (EVENT_SUBSCRIBER_ID, CATEGORY, ENTITY_ID);
CREATE INDEX OBSIDIAN.KEY_EVENT_SUBSCR_NU_01 ON OBSIDIAN.EVENT_SUBSCRIPTION (CATEGORY);
ALTER TABLE OBSIDIAN.EVENT_SUBSCRIPTION ADD CONSTRAINT OBSIDIAN.EVENT_SUB_SUBSCRIBER_FK FOREIGN KEY (EVENT_SUBSCRIBER_ID) REFERENCES OBSIDIAN.EVENT_SUBSCRIBER (EVENT_SUBSCRIBER_ID);

CREATE TABLE OBSIDIAN.NOTIFICATION (
    NOTIFICATION_ID    NUMBER(10)        PRIMARY KEY,
    EVENT_LOG_ID    NUMBER(10)        NOT NULL,
    EVENT_SUBSCRIBER_ID    NUMBER(10)    NOT NULL,
    REVISION          NUMBER(10)   default '0'  NOT NULL,
    CREATED_DATE      TIMESTAMP              NOT NULL,  
    CREATED_BY        NVARCHAR2(50)            NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP              NOT NULL,  
    LAST_UPDATED_BY   NVARCHAR2(50)            NOT NULL 
);

CREATE UNIQUE INDEX OBSIDIAN.KEY_NOTIFICATION_UK_01 ON OBSIDIAN.NOTIFICATION (EVENT_LOG_ID, EVENT_SUBSCRIBER_ID);
ALTER TABLE OBSIDIAN.NOTIFICATION ADD CONSTRAINT OBSIDIAN.NOTIFICATION_SUBSCR_FK FOREIGN KEY (EVENT_SUBSCRIBER_ID) REFERENCES OBSIDIAN.EVENT_SUBSCRIBER (EVENT_SUBSCRIBER_ID);
ALTER TABLE OBSIDIAN.NOTIFICATION ADD CONSTRAINT OBSIDIAN.NOTIFICATION_LOG_FK FOREIGN KEY (EVENT_LOG_ID) REFERENCES OBSIDIAN.EVENT_LOG (EVENT_LOG_ID);


CREATE TABLE OBSIDIAN.NOTIF_TEMPLATE (
    NOTIF_TEMPLATE_ID NUMBER(10)         PRIMARY KEY,
    NAME              NVARCHAR2(255)        NOT NULL,
    ADDRESS_TYPE      NVARCHAR2(50)         NOT NULL, 
    CATEGORY          NVARCHAR2(255)        NOT NULL,
    SUBJECT              NCLOB                    NOT NULL,
    BODY              NCLOB                    NOT NULL,
    DEFAULT_TEMPLATE  NUMBER(1) default '1' NOT NULL,
    ACTIVE            NUMBER(1) default '1' NOT NULL,
    REVISION          NUMBER(10)   default '0' NOT NULL,  
    CREATED_DATE      TIMESTAMP                NOT NULL,  
    CREATED_BY        NVARCHAR2(50)             NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP                NOT NULL,  
    LAST_UPDATED_BY   NVARCHAR2(50)            NOT NULL, 
    CONSTRAINT OBSIDIAN.CHK_ADDRESS_TYPE CHECK (ADDRESS_TYPE IN ('EMAIL')) 
);

CREATE UNIQUE INDEX OBSIDIAN.NOTIF_TEMPLATE_UK_01 ON OBSIDIAN.NOTIF_TEMPLATE (NAME);

CREATE TABLE OBSIDIAN.NOTIF_TEMPLATE_ENTITY (
    NOTIF_TEMPLATE_ENTITY_ID NUMBER(10) PRIMARY KEY,
    NOTIF_TEMPLATE_ID        NUMBER(10) NOT NULL,
    ENTITY_ID         NUMBER(10)        NOT NULL,
    REVISION          NUMBER(10) default '0' NOT NULL,  
    CREATED_DATE      TIMESTAMP         NOT NULL,  
    CREATED_BY        NVARCHAR2(50)     NOT NULL,  
    LAST_UPDATED_DATE TIMESTAMP         NOT NULL,  
    LAST_UPDATED_BY   NVARCHAR2(50)     NOT NULL
);

ALTER TABLE OBSIDIAN.NOTIF_TEMPLATE_ENTITY ADD CONSTRAINT OBSIDIAN.NOTIF_TEMPLATE_ENTITY_FK FOREIGN KEY (NOTIF_TEMPLATE_ID) REFERENCES OBSIDIAN.NOTIF_TEMPLATE (NOTIF_TEMPLATE_ID);

CREATE TABLE OBSIDIAN.JOB_HISTORY_CONFIG (
    JOB_HISTORY_CONFIG_ID   NUMBER(10)                        PRIMARY KEY,
    JOB_ID                     NUMBER(10)                           NOT NULL,
    RUNTIME_ORDINAL		NUMBER(4)							NOT NULL,
    SCHEDULED_TIME            TIMESTAMP                        NOT NULL,  
    PARAMETER_NAME            NVARCHAR2(50)                      NOT NULL,
    PARAMETER_TYPE            NVARCHAR2(255)                      NOT NULL,
    VALUE                    NCLOB                              NOT NULL,
    REVISION                   NUMBER(10) default '0'            NOT NULL ,  
    CREATED_DATE            TIMESTAMP                         NOT NULL,  
    CREATED_BY                NVARCHAR2(50)                     NOT NULL,  
    LAST_UPDATED_DATE         TIMESTAMP                         NOT NULL,  
    LAST_UPDATED_BY            NVARCHAR2(50)                     NOT NULL  
);

CREATE INDEX OBSIDIAN.JOB_HIST_CONF_NU_01 ON OBSIDIAN.JOB_HISTORY_CONFIG (JOB_ID, SCHEDULED_TIME, RUNTIME_ORDINAL);
ALTER TABLE OBSIDIAN.JOB_HISTORY_CONFIG ADD CONSTRAINT OBSIDIAN.JOB_HIST_CONF_JOB_FK FOREIGN KEY (JOB_ID) REFERENCES OBSIDIAN.JOB (JOB_ID);
   
    
CREATE TABLE OBSIDIAN.GLOBAL_JOB_CONFIG (
    GLOBAL_JOB_CONFIG_ID    NUMBER(10)                        PRIMARY KEY,
    PARAMETER_NAME            NVARCHAR2(50)                      NOT NULL,
    PARAMETER_TYPE            NVARCHAR2(255)                      NOT NULL,
    VALUE                    NCLOB                              NOT NULL,
    REVISION                   NUMBER(10) default '0'            NOT NULL ,  
    CREATED_DATE            TIMESTAMP                         NOT NULL,  
    CREATED_BY                NVARCHAR2(50)                     NOT NULL,  
    LAST_UPDATED_DATE         TIMESTAMP                         NOT NULL,  
    LAST_UPDATED_BY            NVARCHAR2(50)                     NOT NULL  
);

CREATE TABLE OBSIDIAN.JOB_SUBSCRIPTION (
    JOB_SUBSCRIPTION_ID     NUMBER(10)                    PRIMARY KEY,
    EVENT_SUBSCRIBER_ID        NUMBER(10)                    NOT NULL,
    ALL_JOBS                  NUMBER(1) default '1'        NOT NULL,
    ACTIVE                       NUMBER(1) default '1'        NOT NULL,
    REVISION                NUMBER(10)   default '0'    NOT NULL,  
    CREATED_DATE            TIMESTAMP                   NOT NULL,  
    CREATED_BY                NVARCHAR2(50)               NOT NULL,  
    LAST_UPDATED_DATE         TIMESTAMP                   NOT NULL,  
    LAST_UPDATED_BY            NVARCHAR2(50)                  NOT NULL
);

ALTER TABLE OBSIDIAN.JOB_SUBSCRIPTION ADD CONSTRAINT OBSIDIAN.JOB_SUB_FK FOREIGN KEY (EVENT_SUBSCRIBER_ID) REFERENCES OBSIDIAN.EVENT_SUBSCRIBER (EVENT_SUBSCRIBER_ID);

CREATE TABLE OBSIDIAN.JOB_SUBSCRIPTION_JOB (
    JOB_SUBSCRIPTION_JOB_ID     NUMBER(10)                    PRIMARY KEY,
    JOB_SUBSCRIPTION_ID            NUMBER(10)                    NOT NULL,
    JOB_ID                        NUMBER(10)                    NOT NULL,
    REVISION                    NUMBER(10)   default '0'    NOT NULL,  
    CREATED_DATE                TIMESTAMP                   NOT NULL,  
    CREATED_BY                    NVARCHAR2(50)               NOT NULL,  
    LAST_UPDATED_DATE             TIMESTAMP                   NOT NULL,  
    LAST_UPDATED_BY                NVARCHAR2(50)               NOT NULL
);

ALTER TABLE OBSIDIAN.JOB_SUBSCRIPTION_JOB ADD CONSTRAINT OBSIDIAN.JOB_SUB_SUB_FK FOREIGN KEY (JOB_SUBSCRIPTION_ID) REFERENCES OBSIDIAN.JOB_SUBSCRIPTION (JOB_SUBSCRIPTION_ID);
ALTER TABLE OBSIDIAN.JOB_SUBSCRIPTION_JOB ADD CONSTRAINT OBSIDIAN.JOB_SUB_JOB_FK FOREIGN KEY (JOB_ID) REFERENCES OBSIDIAN.JOB (JOB_ID);

CREATE TABLE OBSIDIAN.JOB_SUBSCRIPTION_MODE (  
    JOB_SUBSCRIPTION_MODE_ID    NUMBER(10)                    PRIMARY KEY,
    JOB_SUBSCRIPTION_ID         NUMBER(10)                  NOT NULL,  
    STATUS                      NVARCHAR2(30)                NOT NULL,
    REVISION                    NUMBER(10)   default '0'    NOT NULL,  
    CREATED_DATE                TIMESTAMP                   NOT NULL,  
    CREATED_BY                    NVARCHAR2(50)               NOT NULL,  
    LAST_UPDATED_DATE             TIMESTAMP                   NOT NULL,  
    LAST_UPDATED_BY                NVARCHAR2(50)               NOT NULL,
    CONSTRAINT OBSIDIAN.JOB_SUB_MODE_STATUS CHECK (STATUS IN ('FAILED','DIED','COMPLETED','CONDITIONAL','RECOVERY'))
);
    
CREATE INDEX OBSIDIAN.JOB_SUB_MODE_NU ON OBSIDIAN.JOB_SUBSCRIPTION_MODE (JOB_SUBSCRIPTION_ID);
ALTER TABLE OBSIDIAN.JOB_SUBSCRIPTION_MODE ADD CONSTRAINT OBSIDIAN.JOB_SUB_MODE_FK FOREIGN KEY (JOB_SUBSCRIPTION_ID) REFERENCES OBSIDIAN.JOB_SUBSCRIPTION (JOB_SUBSCRIPTION_ID);

CREATE TABLE OBSIDIAN.JOB_SUB_MODE_CONDITION (  
    JOB_SUB_MODE_CONDITION_ID    NUMBER(10)                    PRIMARY KEY,
    JOB_SUBSCRIPTION_MODE_ID    NUMBER(10)                  NOT NULL,  
    CONTEXT_KEY                    NVARCHAR2(255)                NOT NULL,
    OPERATOR                    NVARCHAR2(30)                 NOT NULL,
    VALUE                        NVARCHAR2(2000)                    NULL,
    REVISION                    NUMBER(10)   default '0'    NOT NULL,  
    CREATED_DATE                TIMESTAMP                   NOT NULL,  
    CREATED_BY                    NVARCHAR2(50)               NOT NULL,  
    LAST_UPDATED_DATE             TIMESTAMP                   NOT NULL,  
    LAST_UPDATED_BY                NVARCHAR2(50)               NOT NULL,
    CONSTRAINT OBSIDIAN.JOB_SUB_MODE_COND_OP CHECK (OPERATOR IN ('EQUALS','NOT_EQUALS','IN','NOT_IN','GREATER_THAN','LESS_THAN','GREATER_THAN_OR_EQUAL','LESS_THAN_OR_EQUAL','STARTS_WITH','ENDS_WITH','CONTAINS','EXISTS','NOT_EXISTS','REGEXP'))
);

CREATE INDEX OBSIDIAN.JOB_SUB_MODE_COND_NU ON OBSIDIAN.JOB_SUB_MODE_CONDITION (JOB_SUBSCRIPTION_MODE_ID);
ALTER TABLE OBSIDIAN.JOB_SUB_MODE_CONDITION ADD CONSTRAINT OBSIDIAN.JOB_SUB_MODE_COND_FK FOREIGN KEY (JOB_SUBSCRIPTION_MODE_ID) REFERENCES OBSIDIAN.JOB_SUBSCRIPTION_MODE (JOB_SUBSCRIPTION_MODE_ID);

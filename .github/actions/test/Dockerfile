FROM        zingolabs/zcashdebian:latest
WORKDIR     /zcash
COPY        .  .
RUN         make
ENTRYPOINT  ["./qa/zcash/full_test_suite.py"]

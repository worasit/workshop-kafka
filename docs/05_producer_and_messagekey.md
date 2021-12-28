# Producer and Messages Keys

## Producer

- Producer can choose to receive acknowledgement of data writes:
    - `acks=0` producer won't wait for acknowledgement (possible data loss)
    - `acks=1` producer will wait for leader acknowledgement (limited data loss)
    - `acks=all` Lead + relicas acknowledgement (no data loss)

## Message Keys

- Producer can choose to send a `key` with the message (string,number,etc..)
- If `key=null`, data is sent round-robin (broker 101, 102 then 103)
- If a key is sent, then all messages for that key will always go to the same partition
- A key is basically sent if you need message ordering for a specific field (ex. truck_id)
    - The specific key will go to specific partition, we could not specify partition
sudo vi /etc/systemd/system/zookeeper.service
sudo vi /etc/systemd/system/kafka.service

sudo systemctl enable zookeeper
sudo systemctl enable kafka

sudo systemctl start kafka
# view service log
sudo journalctl -u kafka

sudo tail -n 100 -f ~/kafka/logs/kafkaServer.out

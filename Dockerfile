FROM nginx
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install httrack -y
RUN echo 'httrack "$TARGET_HOST" -O "/usr/share/nginx/html" "$FILTER" --update' > /var/httrack.sh
RUN rm -rf /usr/share/nginx/html/*
RUN touch /usr/share/nginx/html/hts-log.txt
#RUN service cron start
#RUN crontab -l > /var/tempCron
#RUN echo "00 00 * * * bash /var/httrack.sh" >> /var/tempCron
#RUN crontab /var/tempCron
#RUN rm /var/tempCron
CMD nohup httrack "$TARGET_HOST" -O "/usr/share/nginx/html" "$FILTER" & sleep 5 && service nginx start && tail /usr/share/nginx/html/hts-log.txt -f
EXPOSE 80

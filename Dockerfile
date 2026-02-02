# Use official Tomcat base image
FROM tomcat:9.0-jdk11

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your webapp to Tomcat webapps ROOT
COPY src/main/webapp /usr/local/tomcat/webapps/ROOT

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]


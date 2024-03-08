# RabbitMQ Cluster with HAProxy Docker Compose

This project provides a Docker Compose configuration for setting up a RabbitMQ cluster with HAProxy.

## Prerequisites

- Docker
- Docker Compose

## Getting Started

1. Clone this repository:

2. Navigate to the project directory:

3. Start the RabbitMQ cluster and HAProxy:

  ```bash
  docker compose up -d
  ```

4. Verify that the containers are running:

  ```bash
  docker compose ps
  ```

## Configuration

The configuration for the RabbitMQ cluster and HAProxy can be found in the `compose.yml` file. You can modify this file to customize the cluster and proxy settings according to your requirements.

## Usage

Once the containers are up and running, you can access the RabbitMQ management interface by navigating to [http://localhost:15672](http://localhost:15672) in your web browser. The default username and password are `digilabs`.
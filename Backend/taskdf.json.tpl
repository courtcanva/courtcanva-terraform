{
    "family": "CCS-F-UAT-TASKD",
    "networkMode": "awsvpc",
    "containerDefinitions": [
        {
            "name": "CCS-F-UAT-CONTAINER",
            "image": "{{image}}",
            "portMappings": [
                {
                    "containerPort": 8080,
                    "hostPort": 8080,
                    "protocol": "tcp"
                }
            ],
            "secrets": [
                {
                  "name": "PORT",
                  "valueFrom": "arn:aws:ssm:ap-southeast-2:497551902879:parameter/PORT"
                },
                {
                    "name": "API_PREFIX",
                    "valueFrom": "arn:aws:ssm:ap-southeast-2:497551902879:parameter/API_PREFIX"
                  },
                  {
                    "name": "MONGO_URI",
                    "valueFrom": "arn:aws:ssm:ap-southeast-2:497551902879:parameter/MONGO_URI"
                  }
              ],
              "essential": true
        }
    ],
    "requiresCompatibilities": [
        "FARGATE"
    ],
    "cpu": "1vCPU",
    "memory": "2GB",
    "executionRoleArn": "arn:aws:iam::497551902879:role/ecsTaskExecutionRole"
}

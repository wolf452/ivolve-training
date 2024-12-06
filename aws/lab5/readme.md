
# RESTful API with AWS Lambda, API Gateway, and DynamoDB

This project demonstrates how to build a RESTful API using **AWS Lambda**, **API Gateway**, and **DynamoDB**. It includes creating a database, deploying Lambda functions, integrating with API Gateway, and testing using `cURL`.

---

## Features

- **DynamoDB**: Stores items with `id`, `name`, and `price`.
- **Lambda Function**: Supports CRUD operations:
  - Create/Update items.
  - Retrieve single/multiple items.
  - Delete items.
- **API Gateway**: Provides HTTP endpoints.
- **cURL Testing**: Enables route testing.

---

## Prerequisites

- AWS Account.
- Basic understanding of AWS services (Lambda, API Gateway, DynamoDB).
- Node.js or Python environment for Lambda function.

---

## Steps to Build

### 1. **Create a DynamoDB Table**
- Table Name: `http-crud-tutorial-items`
- Partition Key: `id` (String)

### 2. **Develop Lambda Function**
- Name: `http-crud-tutorial-function`
- Runtime: Node.js (or Python)
- Add code for CRUD operations on DynamoDB (refer to the example in the `/src` directory).
- Set execution role: `http-crud-tutorial-role` with simple microservice permissions.

### 3. **Set Up API Gateway**
- API Name: `http-crud-tutorial-api`
- Create routes:
  - `GET /items/{id}`
  - `GET /items`
  - `PUT /items`
  - `DELETE /items/{id}`
- Attach Lambda integration for each route.

---

## Testing with `cURL`

### Create/Update Item
```bash
curl -X "PUT" -H "Content-Type: application/json" -d '{
  "id": "123", 
  "price": 12345, 
  "name": "myitem"
}' https://<API-ID>.execute-api.<REGION>.amazonaws.com/items
```

### Retrieve All Items
```bash
curl https://<API-ID>.execute-api.<REGION>.amazonaws.com/items
```

### Retrieve a Single Item
```bash
curl https://<API-ID>.execute-api.<REGION>.amazonaws.com/items/123
```

### Delete an Item
```bash
curl -X "DELETE" https://<API-ID>.execute-api.<REGION>.amazonaws.com/items/123
```

---

## Clean-Up Instructions

1. **DynamoDB Table**: Delete from the DynamoDB console.
2. **API Gateway**: Delete the API.
3. **Lambda Function**: Remove the function.
4. **CloudWatch Logs**: Delete the associated log group.

---



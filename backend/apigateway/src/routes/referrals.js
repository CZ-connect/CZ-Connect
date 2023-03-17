const express = require('express');
const referralsRoute = express.Router();


referralsRoute.get('/', async function(req, res, next) {
    res.json(data);
});

referralsRoute.get('/1', async function(req, res, next) {
    res.json(data[1]);
});


const data = [
    {
      "id": 1,
      "status": "pending",
      "participantName": "John Smith",
      "participantEmail": "john.smith@example.com",
      "registrationDate": "2022-01-01 09:00:00"
    },
    {
      "id": 2,
      "status": "approved",
      "participantName": "Mary Johnson",
      "participantEmail": "mary.johnson@example.com",
      "registrationDate": "2022-01-02 11:30:00"
    },
    {
      "id": 3,
      "status": "rejected",
      "participantName": "Bob Anderson",
      "participantEmail": "bob.anderson@example.com",
      "registrationDate": "2022-01-03 14:15:00"
    },
    {
      "id": 4,
      "status": "pending",
      "participantName": "Alice Brown",
      "participantEmail": "alice.brown@example.com",
      "registrationDate": "2022-01-04 10:45:00"
    },
    {
      "id": 5,
      "status": "approved",
      "participantName": "Mark Davis",
      "participantEmail": "mark.davis@example.com",
      "registrationDate": "2022-01-05 12:30:00"
    },
    {
      "id": 6,
      "status": "rejected",
      "participantName": "Emily Garcia",
      "participantEmail": "emily.garcia@example.com",
      "registrationDate": "2022-01-06 15:00:00"
    },
    {
      "id": 7,
      "status": "pending",
      "participantName": "David Hernandez",
      "participantEmail": "david.hernandez@example.com",
      "registrationDate": "2022-01-07 09:30:00"
    },
    {
      "id": 8,
      "status": "approved",
      "participantName": "Sarah Lee",
      "participantEmail": "sarah.lee@example.com",
      "registrationDate": "2022-01-08 13:15:00"
    },
    {
      "id": 9,
      "status": "rejected",
      "participantName": "Tom Miller",
      "participantEmail": "tom.miller@example.com",
      "registrationDate": "2022-01-09 16:45:00"
    },
    {
      "id": 10,
      "status": "pending",
      "participantName": "Karen Perez",
      "participantEmail": "karen.perez@example.com",
      "registrationDate": "2022-01-10 11:00:00"
    }
  ]

  
  module.exports = referralsRoute;
  
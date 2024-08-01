import json
import unittest
from unittest.mock import Mock, patch
from handler import lambda_handler


class HandlerTestCase(unittest.TestCase):

    def setUp(self) -> None:

        self.test_data = {
            "version": "latest",
            "basics": {
                "name": "John Doe",
                "label": "Programmer",
                "image": "",
                "email": "john@gmail.com",
                "phone": "(912) 555-4321",
                "url": "https://johndoe.com",
            },
        }

        self.table = Mock()
        self.table.get_item.return_value = {"Item": self.test_data}
        self.dynamodb = Mock()
        self.dynamodb.Table.return_value = self.table

        self.boto3_resource_patch = patch("boto3.resource", return_value=self.dynamodb)
        self.boto3_resource_patch.start()

    def test_handler(self):

        event = {}
        context = {}

        response = lambda_handler(event, context)

        self.assertIn("statusCode", response)
        self.assertEqual(response["statusCode"], 200)
        self.assertIn("body", response)
        self.assertEqual(response["body"], json.dumps(self.test_data))

    def test_handler_not_found(self):
        self.table.get_item.return_value = {"Item": None}

        event = {}
        context = {}

        response = lambda_handler(event, context)

        self.assertIn("statusCode", response)
        self.assertEqual(response["statusCode"], 404)
        self.assertIn("body", response)

    def tearDown(self) -> None:
        self.boto3_resource_patch.stop()
        return super().tearDown()

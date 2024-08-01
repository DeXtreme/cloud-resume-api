import json
import boto3
import logging
from decimal import Decimal


def lambda_handler(event: dict, context: dict):
    """Handle http request"""

    db = boto3.resource("dynamodb")
    table = db.Table("Resumes")

    try:
        result = table.get_item(Key={"version": "latest"})
        resume = result.get("Item", {})
    except Exception as e:
        logging.exception("An error occured")
        return get_response(500, {"detail": "Server error encountered"})

    if resume:
        return get_response(200, resume)

    return get_response(404, {"detail": "Resume not found"})


def get_response(status_code: int, body: dict) -> dict:
    """Generate response object"""

    def decimal_serializer(obj):
        if isinstance(obj, Decimal):
            return str(obj)
        raise TypeError("Type not serializable")

    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET",
        },
        "body": json.dumps(body, default=decimal_serializer),
    }

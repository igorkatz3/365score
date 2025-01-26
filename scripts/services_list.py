import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError

def list_services_in_us_east_1():
    """List AWS services being used in the us-east-1 region."""
    region = "us-east-1"
    try:
        # Initialize the client for the tagging API
        client = boto3.client('resourcegroupstaggingapi', region_name=region)

        # Call the API to get resources and group them by service
        paginator = client.get_paginator('get_resources')
        services = set()

        for page in paginator.paginate():
            for resource in page.get('ResourceTagMappingList', []):
                arn = resource.get('ResourceARN', '')
                service = arn.split(':')[2]  # Extract the service name from the ARN
                services.add(service)

        # Display the list of services
        if services:
            print(f"Services in use at {region}:")
            for service in sorted(services):
                print(f"  - {service}")
        else:
            print(f"No services found in use at {region}.")

    except (NoCredentialsError, PartialCredentialsError):
        print("AWS credentials not found or incomplete. Please configure them correctly.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    list_services_in_us_east_1()


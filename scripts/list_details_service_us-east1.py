import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError

def list_ec2_instances(region):
    """List EC2 instances in the region."""
    ec2 = boto3.client('ec2', region_name=region)
    instances = []
    try:
        response = ec2.describe_instances()
        for reservation in response.get('Reservations', []):
            for instance in reservation.get('Instances', []):
                instances.append({
                    "InstanceId": instance.get('InstanceId'),
                    "State": instance.get('State', {}).get('Name'),
                    "InstanceType": instance.get('InstanceType'),
                    "LaunchTime": instance.get('LaunchTime').strftime('%Y-%m-%d %H:%M:%S'),
                })
    except Exception as e:
        print(f"Error fetching EC2 instances for region {region}: {e}")
    return instances

def list_s3_buckets(region):
    """List S3 buckets."""
    s3 = boto3.client('s3', region_name=region)
    buckets = []
    try:
        response = s3.list_buckets()
        for bucket in response.get('Buckets', []):
            # Check if bucket is in the region
            bucket_location = s3.get_bucket_location(Bucket=bucket['Name']).get('LocationConstraint', 'us-east-1')
            if bucket_location == region or (region == 'us-east-1' and bucket_location is None):
                buckets.append(bucket.get('Name'))
    except Exception as e:
        print(f"Error fetching S3 buckets for region {region}: {e}")
    return buckets

def list_rds_instances(region):
    """List RDS instances."""
    rds = boto3.client('rds', region_name=region)
    instances = []
    try:
        response = rds.describe_db_instances()
        for db_instance in response.get('DBInstances', []):
            instances.append({
                "DBInstanceIdentifier": db_instance.get('DBInstanceIdentifier'),
                "Engine": db_instance.get('Engine'),
                "DBInstanceStatus": db_instance.get('DBInstanceStatus'),
                "Endpoint": db_instance.get('Endpoint', {}).get('Address'),
            })
    except Exception as e:
        print(f"Error fetching RDS instances for region {region}: {e}")
    return instances

def list_lambda_functions(region):
    """List Lambda functions."""
    lambda_client = boto3.client('lambda', region_name=region)
    functions = []
    try:
        paginator = lambda_client.get_paginator('list_functions')
        for page in paginator.paginate():
            for function in page.get('Functions', []):
                functions.append({
                    "FunctionName": function.get('FunctionName'),
                    "Runtime": function.get('Runtime'),
                    "LastModified": function.get('LastModified'),
                })
    except Exception as e:
        print(f"Error fetching Lambda functions for region {region}: {e}")
    return functions

def list_services_in_us_east_1():
    """List resources for the us-east-1 region."""
    region = "us-east-1"
    print(f"\nListing resources for region: {region}")
    services = {
        "EC2 Instances": list_ec2_instances(region),
        "S3 Buckets": list_s3_buckets(region),
        "RDS Instances": list_rds_instances(region),
        "Lambda Functions": list_lambda_functions(region),
    }
    
    # Display the results
    for service, resources in services.items():
        print(f"\n{service}:")
        if resources:
            for resource in resources:
                print(f"  - {resource}")
        else:
            print("  No resources found.")

if __name__ == "__main__":
    try:
        list_services_in_us_east_1()
    except (NoCredentialsError, PartialCredentialsError):
        print("AWS credentials not found. Please configure them correctly.")
    except Exception as e:
        print(f"An error occurred: {e}")


from aws_cdk import App, Stack
from aws_cdk import aws_s3 as s3
from aws_cdk import aws_dynamodb as dynamodb
from constructs import Construct
from aws_cdk import RemovalPolicy

class TerraformBackendStack(Stack):
    def __init__(self, scope: Construct, id: str, **kwargs):
        super().__init__(scope, id, **kwargs)

        # Création du bucket S3 pour stocker l'état Terraform
        self.s3_bucket = s3.Bucket(
            self,
            "TerraformStateBucket",
            bucket_name="terraform-culturedevops",
            versioned=True,  # Active le versioning pour éviter la perte de données
            encryption=s3.BucketEncryption.S3_MANAGED,
            block_public_access=s3.BlockPublicAccess.BLOCK_ALL,
            removal_policy=RemovalPolicy.RETAIN,  # Ne pas supprimer en cas de `cdk destroy`
        )

        # Création de la table DynamoDB pour le verrouillage Terraform
        self.dynamodb_table = dynamodb.Table(
            self,
            "TerraformLockTable",
            table_name="terraform-locks",
            partition_key=dynamodb.Attribute(
                name="LockID", type=dynamodb.AttributeType.STRING
            ),
            billing_mode=dynamodb.BillingMode.PAY_PER_REQUEST,
            removal_policy=RemovalPolicy.RETAIN,  # Préserve la table même après destruction de la stack
        )


app = App()
TerraformBackendStack(app, "TerraformBackendStack")
app.synth()

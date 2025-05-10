# Example bash to backing up data
DATE=$(date +'%Y%m%d%H%M%S')
S3_BUCKET=${BUCKET_URL}
DB_HOST=${DB_HOST}
DB_PORT=${DB_PORT}
DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}
DB_NAME=${DB_NAME}
BACKUP_FILE="/backup/${DB_NAME}_${DATE}.sql"


echo "Backing up ${DB_NAME}..."
PGPASSWORD=$DB_PASSWORD pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME > $BACKUP_FILE

# Upload to bucket S3 in this case
echo "upload started..."
aws s3 cp $BACKUP_FILE $S3_BUCKET$BACKUP_FILE
echo "done <3"

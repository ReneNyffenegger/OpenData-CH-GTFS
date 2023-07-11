URL=https://opentransportdata.swiss/dataset/507c734f-0d9f-48be-843c-7bfd3bf5ec15/resource/399d1107-838e-406b-81c5-89db39e69041/download/gtfs_fp2023_2023-07-05_04-15.zip

if [ -f data/gtfs-ch.zip ]; then
    echo zip file already downloaded.
else

    echo "Downloading zip file..."
    if ! curl -o "data/gtfs-ch.zip" "$URL"; then
        echo "Failed to download zip file."
        exit 1
    fi
    echo "Zip file downloaded successfully."

    if ! unzip -o data/gtfs-ch.zip -d data; then
         echo Failed to unzip $FILE
         exit 1
    fi
fi

admin=sys/elCaro
connect_identifier=localhost/FREEPDB1

cd load

sqlplus -s          $admin@$connect_identifier  as sysdba @create-schema.sql
sqlplus -s gtfs_ch/gtfs_ch@$connect_identifier            @create-tables.sql

sqlldr     gtfs_ch/gtfs_ch@$connect_identifier control=agency.ctl
sqlldr     gtfs_ch/gtfs_ch@$connect_identifier control=calendar.ctl
sqlldr     gtfs_ch/gtfs_ch@$connect_identifier control=calendar_dates.ctl
sqlldr     gtfs_ch/gtfs_ch@$connect_identifier control=routes.ctl
sqlldr     gtfs_ch/gtfs_ch@$connect_identifier control=trips.ctl
sqlldr     gtfs_ch/gtfs_ch@$connect_identifier control=stops.ctl
sqlldr     gtfs_ch/gtfs_ch@$connect_identifier control=stop_times.ctl
sqlldr     gtfs_ch/gtfs_ch@$connect_identifier control=transfers.ctl

sqlplus -s gtfs_ch/gtfs_ch@$connect_identifier @post-process.sql

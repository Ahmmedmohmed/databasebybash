#! /usr/bin/bash

DB_DIR="DB"

# التحقق من وجود المجلد الأساسي
if [ ! -d "$DB_DIR" ]; then
    mkdir "$DB_DIR"
fi
cd "$DB_DIR"


# عرض القائمة الرئيسية
while true
do
    echo "Select an option:"
    echo "1- Create Database"
    echo "2- List Databases"
    echo "3- Connect To Database"
    echo "4- Drop Database"
    echo "5- Exit"

    read -p "Enter your choice: " choice

    case $choice in
        1)
          #!/bin/bash

echo "Enter Database Name: "
read db_name

# Check if the database name contains special characters or spaces
if [[ "$db_name" =~ [^a-zA-Z0-9_] ]]
then
    echo "Database name cannot contain special characters or spaces."
    return
fi

# Check if the database name starts with a number
if [[ "$db_name" =~ ^[0-9] ]]
then
    echo "Database name cannot start with a number."
    return
fi

# Check if the database directory already exists
if [ -d "$db_name" ]
then
    echo "Database already exists."
else
    mkdir "$db_name"
    echo "Database created."
fi
;;
        2)
            ls -d */
            ;;

        3)
            read -p "Enter Database Name to Connect: " db_name

            if [[ "$db_name" =~ [[:punct:][:space:]] ]] 
            then
                echo "Invalid characters in the name."
                
                 return
            fi
                        
            if [ -d "$db_name" ]
            then
                cd "$db_name"
                # عرض قائمة قاعدة البيانات
                while true
                do
                    echo "Select an option:- "
                    echo "1. Create Table"
                    echo "2. List Tables"
                    echo "3. Drop Table"
                    echo "4. Insert into Table"
                    echo "5. Select From Table"
                    echo "6. Delete From Table"
                    echo "7. Update Table"
                    echo "8. Back"

                    read -p "Enter your choice: " db_choice

                    case $db_choice in
                        1)
                            #!/bin/bash

# دخل اسم الجدول
read -p "Enter Table Name: " table_name

# التحقق من اسم الجدول
if [[ "$table_name" =~ [^a-zA-Z0-9_] ]]; then
    echo "Table name cannot contain special characters or spaces."
    exit 1
fi

# التحقق من بداية اسم الجدول بالرقم
if [[ "$table_name" =~ ^[0-9] ]]; then
    echo "Table name cannot start with a number."
    exit 1
fi

# التحقق من وجود الجدول
if [ -f "${table_name}_data" ]; then
    echo "Table already exists."
    exit 1
else
    # إنشاء ملفات البيانات والميتاداتا للجدول
    touch "${table_name}_data" "${table_name}_metadata"

    # دخول أسماء الأعمدة وأنواع البيانات
    echo "Enter column details (press Enter after each column):"
    declare -a column_names=()
    declare -a column_types=()

    # إضافة العمود الأول (ID) بشكل افتراضي
    read -p "Primary key column name: " primary_key_name
    read -p "Data type for $primary_key_name (1 for integer, 2 for string): " primary_key_type
    case "$primary_key_type" in
        1)
            column_types+=("integer")
            ;;
        2)
            column_types+=("string")
            ;;
        *)
            echo "Invalid data type. Defaulting to integer."
            column_types+=("integer")
    esac
    column_names+=("$primary_key_name")
    echo "$primary_key_name:${column_types[-1]}" >> "${table_name}_metadata"
    echo "Note: $primary_key_name will be set as the primary key column."

    # طلب المزيد من الأعمدة
    while true; do
        read -p "Column name (or press Enter to finish): " column_name
        if [ -z "$column_name" ]; then
            break
        fi

        # طلب نوع البيانات
        read -p "Data type (1 for integer, 2 for string): " data_type
        case "$data_type" in
            1)
                column_types+=("integer")
                ;;
            2)
                column_types+=("string")
                ;;
            *)
                echo "Invalid data type. Please try again."
                continue
        esac
        column_names+=("$column_name")
        echo "$column_name:${column_types[-1]}" >> "${table_name}_metadata"
    done

    echo "Table '$table_name' created successfully."
fi
;;
                        2)## ls
                                
                            ;;

                        3)
                            read -p "Enter Table Name to Drop: " table_name
                            
            if [[ "$table_name" =~ [[:punct:][:space:]] ]] 
            then
                echo "Invalid characters in the name."
                
                 return
            fi
                            if [ -f "${table_name}_data" ]
                            then
                                rm "${table_name}_data" "${table_name}_metadata"
                                echo "Table dropped."
                            else
                                echo "Table does not exist."
                            fi
                            ;;

                        4) ##insert

        5)
                            read -p "Enter Table Name to Select from: " table_name
                            
            if [[ "$table_name" =~ [[:punct:][:space:]] ]] 
            then
                echo "Invalid characters in the name."
                
                 return
            fi
                            if [ -f "${table_name}_data" ]
                            then
                                cat "${table_name}_data"
                            else
                                echo "Table does not exist."
                            fi
                            ;;

                        6) ##DALT
                             
                        7)
                           read -p "Enter Table Name to Update: " table_name

if [[ "$table_name" =~ [[:punct:][:space:]] ]]; then
    echo "Invalid characters in the name."
    exit 1
fi

if [ -f "${table_name}_data" ] && [ -f "${table_name}_metadata" ]; then
    echo "Enter id to update:"
    read id

    # Check if the specified id exists in the data file
    if grep -q "^$id," "${table_name}_data"; then
        # Read column details from metadata file
        declare -a column_names=()
        declare -a column_types=()
        while read -r line; do
            IFS=':' read -ra column_info <<< "$line"
            column_names+=("${column_info[0]}")
            column_types+=("${column_info[1]}")
        done < "${table_name}_metadata"

        # Prompt user to update each column
        new_data=()
        for i in "${!column_names[@]}"; do
            column_name="${column_names[$i]}"
            column_type="${column_types[$i]}"

            if [ "$column_name" = "id" ]; then
                # Validate and update the id column
                while true; do
                    read -p "Enter new value for column 'id' (type: $column_type): " id_value
                    if [ -z "$id_value" ]; then
                        echo "The id column cannot be empty."
                    elif ! [[ "$id_value" =~ ^[0-9]+$ ]]; then
                        echo "Invalid integer value for the id column."
                    elif grep -q "^$id_value," "${table_name}_data" && [ "$id_value" != "$id" ]; then
                        echo "The id '$id_value' already exists in the table."
                    else
                        new_data+=("$id_value")
                        break
                    fi
                done
            else
                # Prompt user for updated value and validate based on column type
                while true; do
                    read -p "Enter new value for column '$column_name' (type: $column_type, leave empty for NULL): " value
                    if [ -z "$value" ]; then
                        value="NULL"
                        new_data+=("$value")
                        break
                    fi

                    case "$column_type" in
                        integer)
                            if [[ "$value" =~ ^[0-9]+$ ]]; then
                                new_data+=("$value")
                                break
                            else
                                echo "Invalid integer value for column '$column_name'"
                            fi
                            ;;
                        string)
                            if [[ "$value" =~ ^[a-zA-Z]+$ ]]; then
                                new_data+=("$value")
                                break
                            else
                                echo "Invalid string value for column '$column_name'. Please enter only letters."
                            fi
                            ;;
                        *)
                            echo "Unknown data type '$column_type' for column '$column_name'"
                            exit 1
                            ;;
                    esac
                done
            fi
        done

        # Remove the existing row with the specified id
        sed -i "/^$id,/d" "${table_name}_data"

        # Append the new data to the file
        echo "$(IFS=','; echo "${new_data[*]}")" >> "${table_name}_data"
        echo "Data updated."
    else
        echo "Record with id $id not found in the table."
    fi
else
    echo "Table does not exist."
fi
;;
                        8)
                            cd ..
                            break
                            ;;

                        *)
                            echo "Invalid choice."
                            ;;
                    esac
                done
            else
                echo "Database does not exist."
            fi
            ;;

        4)
            read -p "Enter Database Name to Drop: " db_name
            
            if [[ "$db_name" =~ [[:punct:][:space:]] ]] 
            then
                echo "Invalid characters in the name."
                
                 return
            fi
            if [ -d "$db_name" ]
            then
                rm -r "$db_name"
                echo "Database dropped."
            else
                echo "Database does not exist."
            fi
            ;;

        5)
            break
            ;;

        *)
            echo "Invalid choice."
            ;;
    esac
done

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
                        2)
                                ls -p | grep -v / | grep -v 'meta' | sed 's/\_data\b//'
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

                        4)


#!/bin/bash

# الحصول على اسم الجدول من المستخدم#!/bin/bash

# الحصول على اسم الجدول من المستخدم
#!/bin/bash

# الحصول على اسم الجدول من المستخدم
read -p "Enter Table Name to insert: " table_name

# التحقق من وجود ملف الميتاداتا للجدول
if [ ! -f "${table_name}_metadata" ]; then
    echo "Table '$table_name' does not exist."
    exit 1
fi

# قراءة معلومات الأعمدة من ملف الميتاداتا
declare -a column_names=()
declare -a column_types=()
while IFS=':' read -r name type; do
    column_names+=("$name")
    column_types+=("$type")
done < "${table_name}_metadata"

# التحقق من أن أول عمود غير فارغ وغير مكرر
read -p "Enter value for ${column_names[0]} (${column_types[0]}): " first_value
if [ -z "$first_value" ]; then
    echo "The first column cannot be empty."
    exit 1
fi

# التحقق من أن القيمة غير مكررة في العمود الأول لأي صف
if grep -q "^$first_value:" "${table_name}_data"; then
    echo "The value '$first_value' in the first column already exists."
    exit 1
fi

# جمع القيم في صف واحد
row="$first_value"
for ((i=1; i<${#column_names[@]}; i++)); do
    read -p "Enter value for ${column_names[i]} (${column_types[i]}): " value
    row="$row:$value"
done

# إضافة الصف إلى ملف البيانات
echo "$row" >> "${table_name}_data"

echo "Data added to table '$table_name' successfully."

;;
        5)
                          #!/bin/bash

# الحصول على اسم الجدول من المستخدم
read -p "Enter Table Name to Select from: " table_name

# التحقق من وجود أحرف غير صالحة في الاسم
if [[ "$table_name" =~ [[:punct:][:space:]] ]]; then
    echo "Invalid characters in the name."
    exit 1
fi

# التحقق من وجود ملف البيانات
if [ ! -f "${table_name}_data" ]; then
    echo "Table does not exist."
    exit 1
fi

# تقديم الخيارات للمستخدم
echo "Choose an option:"
echo "1. Display all data"
echo "2. Display a specific column"
echo "3. Display a specific row"
read -p "Enter your choice (1/2/3): " choice

case $choice in
    1)
        # عرض كل البيانات
        cat "${table_name}_data"
        ;;
    2)
        # عرض عمود محدد
        read -p "Enter the column number to display: " col_num
        awk -v col="$col_num" -F":" '{print $col}' "${table_name}_data"
        ;;
    3)
        # عرض صف محدد
        read -p "Enter the row number to display: " row_num
        sed -n "${row_num}p" "${table_name}_data"
        ;;
    *)
        echo "Invalid choice."
        exit 1
        ;;
esac

                            ;;

                        6)
                             read -p "Enter table name: " table

    if [[ -f ${table}_data ]]; then
        echo "Choose an option:"
        echo "1. Delete row"
        echo "2. Delete column"
        echo "3. Delete specific data"
        read -p "Enter your choice: " choice

        case $choice in
            1)
                # Delete row
                read -p "Enter row number to delete (excluding header): " row_num
                if [[ $row_num -ge 1 ]]; then
                    # Adjust row_num to account for header
                    row_num=$((row_num + 1))
                    sed -i "${row_num}d" $table
                    echo "Row $row_num deleted from ${table}_data."
                else
                    echo "Invalid row number."
                fi
                ;;
            2)
                # Delete column
                read -p "Enter column number to delete: " col_num
                if [[ $col_num -ge 1 ]]; then
                  awk -v col=$col_num 'BEGIN {FS=OFS=","} { for (i=col; i<NF; i++) $i=$(i+1); NF--; print }' $table >temp && mv temp ${table}_data
                    echo "Column $col_num deleted from $table."
                else
                    echo "Invalid column number."
                fi
                ;;
            3)
                # Delete specific data
                read -p "Enter data to delete: " data
                awk -v data="${data}_data" 'BEGIN {FS=OFS=","} 
                {
                    for(i=1; i<=NF; i++) {
                        if ($i == data) $i=""
                    } 
                    print
                }' ${table}_data > temp && mv temp $table
                echo "Data '$data' deleted from $table."
                ;;
            *)
                echo "Invalid choice."
                ;;
        esac
    else
        echo "Table $table does not exist."
    fi
;;
                        7)
                          #!/bin/bash

# الحصول على اسم الجدول من المستخدم
read -p "Enter Table Name to Modify: " table_name

# التحقق من وجود أحرف غير صالحة في الاسم
if [[ "$table_name" =~ [[:punct:][:space:]] ]]; then
    echo "Invalid characters in the name."
    exit 1
fi

# التحقق من وجود ملف البيانات
if [ ! -f "${table_name}_data" ]; then
    echo "Table does not exist."
    exit 1
fi

# قراءة معلومات الأعمدة من ملف الميتاداتا
declare -a column_names=()
declare -a column_types=()
while IFS=':' read -r name type; do
    column_names+=("$name")
    column_types+=("$type")
done < "${table_name}_metadata"

# الحصول على رقم الصف والعمود من المستخدم
read -p "Enter the row number to modify: " row_num
read -p "Enter the column number to modify: " col_num

# التحقق من صلاحية المدخلات
if ! [[ "$row_num" =~ ^[0-9]+$ ]] || ! [[ "$col_num" =~ ^[0-9]+$ ]]; then
    echo "Invalid row or column number."
    exit 1
fi

# الحصول على القيمة الجديدة
read -p "Enter the new value: " new_value

# التحقق من نوع البيانات للقيمة الجديدة
col_type=${column_types[$((col_num - 1))]}
case $col_type in
    int)
        if ! [[ "$new_value" =~ ^[0-9]+$ ]]; then
            echo "Invalid value type. Expected integer."
            exit 1
        fi
        ;;
    string)
        if [[ "$new_value" =~ [[:punct:][:space:]] ]]; then
            echo "Invalid value type. Expected string without spaces or punctuation."
            exit 1
        fi
        ;;
    *)
        echo "Unknown column type."
        exit 1
        ;;
esac

# إذا كان العمود الأول، تحقق من أن القيمة غير مكررة
if [ "$col_num" -eq 1 ]; then
    if grep -q "^$new_value:" "${table_name}_data"; then
        echo "The value '$new_value' in the first column already exists."
        exit 1
    fi
fi

# تعديل القيمة في الصف والعمود المحددين
awk -v row="$row_num" -v col="$col_num" -v val="$new_value" -F":" 'BEGIN {OFS=FS} NR==row {$col=val} 1' "${table_name}_data" > temp && mv temp "${table_name}_data"

echo "Value updated successfully in row $row_num, column $col_num."

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

import duckdb
import os

print("Starting connection test...") # This is the new line of code

# Get your MotherDuck token from the environment variable
motherduck_token = os.environ.get('MOTHERDUCK_TOKEN')

if not motherduck_token:
    print("Error: The MOTHERDUCK_TOKEN environment variable is not set.")
else:
    try:
        # This is the line that tries to connect to MotherDuck
        con = duckdb.connect(f'md:', config={'motherduck_token': motherduck_token})

        print("Success! The connection to MotherDuck worked.")

        # This runs a simple test query
        result = con.execute("SELECT 'Hello from MotherDuck!'").fetchall()
        print(f"Query Result: {result}")

        # This closes the connection
        con.close()
    except Exception as e:
        # If there's an error, this will print it
        print(f"The connection failed. Here is the exact error:")
        print(e)
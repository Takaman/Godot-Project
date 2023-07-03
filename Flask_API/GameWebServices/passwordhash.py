from werkzeug.security import generate_password_hash, check_password_hash

password = "99009900"
hash = generate_password_hash(password)
print(hash)
print(check_password_hash(hash,password))
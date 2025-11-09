# שימוש בתמונה רשמית של Node, גרסת Slim (Debian/Ubuntu)
FROM node:18-bullseye-slim

# קביעת תיקיית עבודה בתוך הקונטיינר
WORKDIR /app

# העתקת קבצי package.json ו־package-lock.json
COPY package*.json ./

# התקנת התלויות
RUN npm install

# העתקת שאר הקבצים
COPY . .

# חשיפת פורט 3000
EXPOSE 3000

# הפעלת האפליקציה
CMD ["npm", "start"]

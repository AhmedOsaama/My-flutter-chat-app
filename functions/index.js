const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions

exports.pushMsgNotification = functions.firestore.document("chats/{message}")
    .onCreate((snapshot, context) => {
      return admin.messaging().sendToTopic("chats", {
        notification: {
          title: snapshot.data().username,
          body: snapshot.data().message,
        },
      });
    });

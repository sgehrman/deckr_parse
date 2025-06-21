// @ts-check

import Parse from 'parse/node';

// ------------------------------------------------------------
// is current user part of the Admin role?

const isAdmin = async (request) => {
  const queryRole = new Parse.Query(Parse.Role);
  queryRole.equalTo('name', 'Admin');

  const role = await queryRole.first({ useMasterKey: true });

  const relation = new Parse.Relation(role, 'users');

  const admins = relation.query();
  admins.equalTo('username', request.user.get('username'));

  const user = await admins.first({ useMasterKey: true });

  if (user) {
    return true;
  }

  return false;
};

Parse.Cloud.define('isAdmin', async (request) => {
  return isAdmin(request);
});

// ------------------------------------------------------------
// lookup username from email address

Parse.Cloud.define('usernameForEmail', async (request) => {
  const params = request.params;

  const users = new Parse.Query(Parse.User);
  users.equalTo('email', params.email);

  const user = await users.first({ useMasterKey: true });

  if (user) {
    return user.get('username');
  }

  return '';
});

// ------------------------------------------------------------
// ChatMessage file delete handling

Parse.Cloud.beforeDelete('ChatMessage', async (request) => {
  const imageFile = request.object.get('image');
  if (imageFile) {
    try {
      await imageFile.destroy({ useMasterKey: true });
    } catch (error) {
      console.log(error);
      throw new Error('Error deleting chat image');
    }
  }
});

Parse.Cloud.afterSave('ChatMessage', async (request) => {
  const imageFile = request.object.get('image');
  const imageOriginal = request.original ? request.original.get('image') : null;

  if (imageOriginal) {
    // if file hasn't changed, do nothing
    if (imageFile && imageFile.equals(imageOriginal)) {
      return;
    }

    try {
      await imageOriginal.destroy({ useMasterKey: true });
    } catch (error) {
      console.log(error);
      throw new Error('Error deleting chat image');
    }
  }
});

// ------------------------------------------------------------
// User file delete handling

// @ts-ignore eslint doesn't recognize Parse.User, see https://parseplatform.org/Parse-SDK-JS/api/v1.11.0/Parse.Cloud.html
Parse.Cloud.beforeDelete(Parse.User, async (request) => {
  const imageFile = request.object.get('avatar');
  if (imageFile) {
    try {
      await imageFile.destroy({ useMasterKey: true });
    } catch (error) {
      console.log(error);
      throw new Error('Error deleting Parse.User avatar image file');
    }
  }
});

// @ts-ignore eslint doesn't recognize Parse.User, see https://parseplatform.org/Parse-SDK-JS/api/v1.11.0/Parse.Cloud.html
Parse.Cloud.afterSave(Parse.User, async (request) => {
  const imageFile = request.object.get('avatar');
  const imageOriginal = request.original
    ? request.original.get('avatar')
    : null;

  // delete original image if it exists if replacing with a new image
  if (imageOriginal) {
    // if file hasn't changed, do nothing
    if (imageFile && imageFile.equals(imageOriginal)) {
      return;
    }

    try {
      await imageOriginal.destroy({ useMasterKey: true });
    } catch (error) {
      console.log(error);
      throw new Error('Error deleting Parse.User avatar image file');
    }
  }
});

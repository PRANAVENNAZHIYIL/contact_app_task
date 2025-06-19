// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/widgets/snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;

class HouzeoLocalDBFunctions {
  Future<void> createHouzeoLocalDB(sql.Database db) async {
    await db.execute(
        """CREATE TABLE contacts (id INTEGER PRIMARY KEY, profilePic BLOB NULL, first_name TEXT, last_name TEXT, company_name TEXT, phone_number TEXT, email TEXT, isFavorite INTEGER)""");
  }

  Future<sql.Database> openHouzeoLocalDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return sql.openDatabase(
      '${directory.path}/houzeoDataBase',
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await createHouzeoLocalDB(db);
      },
    );
  }

  Future<void> deleteDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final dbPath = '${directory.path}/houzeoDataBase';
    await sql.deleteDatabase(dbPath);
  }

  Future<int?> addNewContact(BuildContext context, ContactModel contact) async {
    int? id;
    final db = await openHouzeoLocalDB();
    try {
      var data = {
        'profilePic': contact.profilePic,
        'first_name': contact.firstName,
        'last_name': contact.lastName,
        'company_name': contact.companyName,
        'phone_number': contact.phoneNumber,
        'email': contact.email,
        'isFavorite': 0,
      };
      id = await db.insert('contacts', data);
      return id;
    } catch (e) {
      errorSnackBar(context, e.toString());
    } finally {
      await db.close();
    }
    return null;
  }

  Future<void> deleteContact(BuildContext context, int id) async {
    final db = await openHouzeoLocalDB();
    try {
      await db.rawDelete('DELETE FROM contacts WHERE id = ?', [id]);
    } catch (e) {
      errorSnackBar(context, e.toString());
    } finally {
      await db.close();
    }
  }

  Future<int?> updateContact(BuildContext context, ContactModel contact) async {
    final isFavorite = contact.isFavorite ? 1 : 0;
    final db = await openHouzeoLocalDB();

    try {
      final rowsAffected = await db.rawUpdate(
        'UPDATE contacts SET '
        'profilePic = ?, '
        'first_name = ?, '
        'last_name = ?, '
        'company_name = ?, '
        'phone_number = ?, '
        'email = ?, '
        'isFavorite = ? '
        'WHERE id = ?',
        [
          contact.profilePic,
          contact.firstName,
          contact.lastName,
          contact.companyName,
          contact.phoneNumber,
          contact.email,
          isFavorite,
          contact.id,
        ],
      );
      return rowsAffected;
    } catch (e) {
      errorSnackBar(context, 'Error updating contact: ${e.toString()}');
      return null;
    } finally {
      await db.close();
    }
  }

  Future<void> addOrRemoveToFavorite(
      BuildContext context, int id, bool isAdd) async {
    final db = await openHouzeoLocalDB();
    try {
      await db.rawUpdate(
        'UPDATE contacts SET '
        'isFavorite = ? '
        'WHERE id = ?',
        [isAdd ? 1 : 0, id],
      );
    } catch (e) {
      errorSnackBar(context, e.toString());
    } finally {
      await db.close();
    }
  }

  Future<List<ContactModel>> getAllContacts(BuildContext context) async {
    final db = await openHouzeoLocalDB();
    try {
      final List<Map<String, dynamic>> value =
          await db.query('contacts', orderBy: "id");
      return value.map((contact) {
        return ContactModel(
          id: contact['id'] as int,
          profilePic: contact['profilePic'] != null
              ? contact['profilePic'] as Uint8List
              : null,
          firstName: contact['first_name'] as String,
          lastName: contact['last_name'] as String,
          companyName: contact['company_name'] as String,
          phoneNumber: contact['phone_number'] as String,
          email: contact['email'] as String,
          isFavorite: (contact['isFavorite'] as int) == 1,
        );
      }).toList();
    } catch (e) {
      errorSnackBar(context, e.toString());
    } finally {
      await db.close();
    }
    return [];
  }
}

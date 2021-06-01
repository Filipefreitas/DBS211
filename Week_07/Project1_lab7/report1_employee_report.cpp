#include <iostream>
#include <occi.h>
#include <iomanip>
using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;

int main(void)
{
	/* OCCI Variables */
	Environment* env = nullptr;
	Connection* conn = nullptr;
	/* Used Variables */
	string user = "dbs211_203c09";
	string pass = "30604132";
	string constr = "myoracle12c.senecacollege.ca:1521/oracle12c";
	try 
	{
		env = Environment::createEnvironment(Environment::DEFAULT);
		conn = env->createConnection(user, pass, constr);

		Statement* stmt = conn->createStatement();
		ResultSet* rs = stmt->executeQuery("SELECT e.employeenumber, e.firstname, e.lastname, o.phone, e.extension FROM employees e LEFT JOIN offices o ON e.officecode = o.officecode WHERE lower(o.city) = 'san francisco' ORDER BY e.employeenumber");

		if (!rs->next()) 
		{
			cout << "ResultSet is empty." << endl;
		}
		else 
		{
			cout << "----------------------------------- Report 1 (Employee Report) -----------------------------------" << endl;
			cout << left << setw(14) << setfill(' ') << "Employee ID";
			cout << left << setw(22) << setfill(' ') << "Frist Name";
			cout << left << setw(22) << setfill(' ') << "Last Name";
			cout << left << setw(22) << setfill(' ') << "Phone";
			cout << left << setw(9) << setfill(' ') << "Extension" << endl;
	
			cout << "------------  ";
			cout << "--------------------  ";
			cout << "--------------------  ";
			cout << "--------------------  ";
			cout << "------------  " << endl;

			do {
				cout << left << setw(14) << setfill(' ') << rs->getInt(1)
					<< left << setw(22) << setfill(' ') << rs->getString(2)
					<< left << setw(22) << setfill(' ') << rs->getString(3)
					<< left << setw(22) << setfill(' ') << rs->getString(4)
					<< left << setw(9) << setfill(' ') << rs->getString(5) << endl;
			} while (rs->next()); 
		}
		
		conn->terminateStatement(stmt);
		env->terminateConnection(conn);
		Environment::terminateEnvironment(env);
	}
	catch (SQLException& sqlExcp) 
	{
		cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
	}

	return 0;
}
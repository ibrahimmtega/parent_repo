#include <Dummy.h>
#include <QCoreApplication>
//clean
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    Dummy d;

    qDebug()<<"Dummy from app repo "<<d.x;

    d.print();

    return a.exec();
}

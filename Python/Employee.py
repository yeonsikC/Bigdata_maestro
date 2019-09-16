#공통 요인을 위한 슈퍼 클래스 생성
class Employee:
    def __init__(self, name):
        self.name = name
    
    def doWork( self ):
        print( 'Employee {0}는 '.format( self.name ), end = '')

#상속받으려면 괄호 안에 슈퍼클래스명 입력
#파이썬은 단일 상속만 지원 ( 다중 상속은 미지원 )
class RegularEmployee( Employee ):
    def __init__( self, name, age):
        super().__init__(name)
        self.age = age
    def doWork( self ):
        super().doWork()
        print( '일반적인 사무업무 수행' )

class SalesEmployee( Employee ):
    def __init__( self, name, age ):
        super().__init__(name)
        self.age = age
    def doWork( self ):
        super().doWork()
        print( '영업업무를 수행' )

def main():
    regularEmployee = RegularEmployee('Hong', 25)
    salesEmployee = SalesEmployee('Kim', 30)
    regularEmployee.doWork()
    salesEmployee.doWork()

if __name__ == '__main__':
    main()
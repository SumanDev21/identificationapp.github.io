public class AccountCont {
    public static List<Account> insertAccounts(List<Account> accounttoInsert){
        insert accounttoInsert;
        return accounttoInsert;
    }
        public static Account insertAccount(Account accounttoInsert){
        insert accounttoInsert;
        return accounttoInsert;
    }
    public static List<Account> getAllAccounts(){
        List<Account> accounts = [SELECT Name,Phone FROM Account];
        return accounts;
    }
    public static void printAllAccounts(){
        List<Account> accounts = getAllAccounts() ;
        for(Account account : accounts){
            System.debug('Accont Name' +account.Name+ 'Account Phone' + account.Phone);
        }
    }
    public static Integer getSize(){
        List<Account> accounts = getAllAccounts() ;
       return accounts.size();
}
}
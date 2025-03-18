-- FINANCIAL BANK ANALYSIS --

-- CREATE A NEW TABLE THAT CONTAINS THE SAME RAW DATA --
CREATE TABLE bank_stat_sept_dec.financial_bank_analysis2
	LIKE bank_stat_sept_dec.financial_bank_analysis;

INSERT INTO financial_bank_analysis2
	SELECT*
		FROM financial_bank_analysis;

SELECT*
	FROM financial_bank_analysis2;
    
UPDATE financial_bank_analysis2
	SET
    Date = TRIM(Date),
    Description = TRIM(Description),
    Category = TRIM(Category),
    `Money In` = TRIM(`Money In`),
    `Money Out` = TRIM(`Money Out`),
    Fees = TRIM(Fees),
    Balance = TRIM(Balance);
    
ALTER TABLE financial_bank_analysis2
	RENAME COLUMN `ï»¿Date` TO `Date`;

-- STANDARDISE THE DATA--

UPDATE financial_bank_analysis2
	SET `date` = STR_TO_DATE(`Date`, '%d/%m/%Y');

SELECT DISTINCT Description
	FROM financial_bank_analysis2;

UPDATE financial_bank_analysis2
	SET Description = TRIM(REPLACE(Description, '(Card 6706)', ''))
		WHERE Description LIKE '%(Card 6706)%';

    SELECT Description
		FROM financial_bank_analysis2
        WHERE Description LIKE '(Card 6706)';
	
    SELECT DISTINCT Category
		FROM financial_bank_analysis2;

select*
from financial_bank_analysis2;
        
UPDATE financial_bank_analysis2
	SET Category = CASE 
    WHEN Category IN ('Public Transport', 'Other Transport') THEN 'Transport'
    WHEN Category IN ('Restaurants') THEN 'Takeaways'
    WHEN Category IN ('Transfer') THEN 'Digital Payments'
	WHEN Category IN ('Salary') THEN 'Other Income'
	WHEN Category IN ('Pharmacy', 'Cellphone', 'Telephone', 'Personal Care', 'Online Store', 'Other Personal & Family',
      'Sport & Hobbies', 'Digital Subscriptions', 'Loans', 'Loan Payments', 'Alcohol', 'Furniture & Appliances', 'Betting/ Lottery' ) THEN 'Other Expenses'
    ELSE Category  
	END;

UPDATE financial_bank_analysis2
SET Category = 'Transfer'
WHERE Category = 'Transfer                                                                              503.24';
        
SELECT*
FROM financial_bank_analysis2;

ALTER TABLE financial_bank_analysis2
	ADD COLUMN Fees_Breakdown VARCHAR(50);
 
 UPDATE financial_bank_analysis2
	SET Fees_Breakdown = 
    CASE 
        WHEN Description LIKE '%Insufficient Funds%' THEN 'Insufficient Funds'
        WHEN Description LIKE '%Capitec Pay Fee%' THEN 'Capitec Pay'
        WHEN Description LIKE '%Prepaid Mobile Purchase Fee%' THEN 'Prepaid Mobile'
        WHEN Description LIKE '%Immediate Payment Fee%' THEN 'Immediate Payment'
        WHEN Description LIKE '%External Payment Fee%' THEN 'External Payment'
        WHEN Description LIKE '%Monthly Account Admin Fee%' THEN 'Monthly Admin Fee'
        WHEN Description LIKE '%Cash Sent%' THEN 'Cash Sent'
        WHEN Description LIKE '%Limit Exceeded Fee%' OR Description LIKE '%Online Purchase Limit%' THEN 'Limit Exceeded'
        WHEN Description LIKE '%International Processing Fee%' THEN 'International Processing'
        WHEN Description LIKE '%ATM Cash Withdrawal Fee%' THEN 'ATM Cash Withdrawal'
        WHEN Description LIKE '%Prepaid Electricity Purchase Fee%' THEN 'Prepaid Electricity'
        ELSE Fees_Breakdown
    END;

UPDATE financial_bank_analysis2
SET Fees = ABS(Fees),
    `Money Out` = ABS(`Money Out`);

 

		




    
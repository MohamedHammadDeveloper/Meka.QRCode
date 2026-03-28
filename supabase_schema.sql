-- Database Schema for WhatsApp Marketing Automation

-- Create Enum for User States
CREATE TYPE user_state AS ENUM ('NEW', 'BROWSING', 'SELECTED', 'INTERESTED');

CREATE TABLE Users (
    Id SERIAL PRIMARY KEY,
    Phone TEXT UNIQUE NOT NULL,
    Name TEXT,
    State user_state DEFAULT 'NEW',
    OptIn BOOLEAN DEFAULT FALSE,
    LastInteraction TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Offers (
    Id SERIAL PRIMARY KEY,
    Title TEXT NOT NULL,
    Description TEXT,
    DiscountValue INT,
    Active BOOLEAN DEFAULT TRUE
);

CREATE TABLE UserOffers (
    Id SERIAL PRIMARY KEY,
    UserId INT REFERENCES Users(Id) ON DELETE CASCADE,
    OfferId INT REFERENCES Offers(Id) ON DELETE CASCADE,
    DateSent TIMESTAMP DEFAULT NOW(),
    IsInterested BOOLEAN DEFAULT FALSE
);

CREATE TABLE MessagesLog (
    Id SERIAL PRIMARY KEY,
    UserId INT REFERENCES Users(Id) ON DELETE CASCADE,
    Message TEXT,
    Direction TEXT, -- 'INBOUND' or 'OUTBOUND'
    Timestamp TIMESTAMP DEFAULT NOW(),
    Status TEXT DEFAULT 'SENT' -- Tracks 'SENT', 'FAILED', etc.
);

-- Insert 10 Sample Offers
INSERT INTO Offers (Title, Description, DiscountValue, Active) VALUES
('خصم 10%', 'خصم 10% على جميع المنتجات لفترة محدودة، تسوق الآن!', 10, TRUE),
('خصم 15%', 'وفر 15% عند الشراء بقيمة 500 ريال أو أكثر.', 15, TRUE),
('شحن مجاني', 'احصل على شحن مجاني لطلبك القادم باستخدام هذا العرض.', 0, TRUE),
('خصم 20%', 'خصم 20% لعملاء الواتساب الحصريين فقط.', 20, TRUE),
('اشترِ 1 واحصل على 1', 'اشترِ أي منتج واحصل على الثاني مجاناً من نفس الفئة.', 50, TRUE),
('خصم 50 ريال', 'خصم فوري 50 ريال على سلتك القادمة.', 50, TRUE),
('خصم 25%', 'عرض نهاية الأسبوع: خصم 25% على قسم الإلكترونيات والأجهزة المدمجة.', 25, TRUE),
('هدية مجانية', 'احصل على هدية مجانية قيمة مع طلبك القادم.', 0, TRUE),
('خصم 30%', 'العرض الذهبي: 30% خصم لمدة 24 ساعة فقط! لا تفوت الفرصة.', 30, TRUE),
('خصم 5%', 'خصم إضافي 5% للمشتركين الجدد في نشرتنا الإعلانية عبر الواتساب.', 5, TRUE);
